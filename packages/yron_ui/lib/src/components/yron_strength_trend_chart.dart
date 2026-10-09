import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import '../theme/yron_theme.dart';

/// One ordered strength sample. [label] is a short axis label; [semanticLabel]
/// should include the caller-formatted date, value and unit for screen readers.
@immutable
class YronStrengthPoint {
  const YronStrengthPoint({
    required this.label,
    required this.value,
    required this.semanticLabel,
  }) : assert(value > double.negativeInfinity && value < double.infinity);

  final String label;
  final double value;
  final String semanticLabel;
}

/// Dependency-free strength trend with a grid, filled line and sample markers.
///
/// Samples are plotted in caller order at equal horizontal intervals, not
/// proportional to elapsed time. The vertical domain fits the samples; constant
/// series and single samples are centered. Each sample is exposed as a separate
/// screen-reader node. Empty series display [emptyLabel] instead of a fake line.
class YronStrengthTrendChart extends StatelessWidget {
  YronStrengthTrendChart({
    super.key,
    required List<YronStrengthPoint> points,
    required this.semanticLabel,
    required this.emptyLabel,
    this.height = 160,
    this.color = YronColors.secondary,
  }) : points = List.unmodifiable(points),
       assert(height >= 48) {
    if (points.any((point) => !point.value.isFinite)) {
      throw ArgumentError.value(points, 'points', 'Values must be finite');
    }
  }

  final List<YronStrengthPoint> points;
  final String semanticLabel;
  final String emptyLabel;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return Semantics(
        label: semanticLabel,
        child: SizedBox(
          height: height,
          child: Center(
            child: Text(
              emptyLabel,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: YronColors.textMuted),
            ),
          ),
        ),
      );
    }

    return Semantics(
      label: semanticLabel,
      explicitChildNodes: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: height,
            child: CustomPaint(
              painter: _StrengthTrendPainter(
                points: points,
                color: color,
                textDirection: Directionality.of(context),
              ),
            ),
          ),
          const SizedBox(height: YronSpacing.sm),
          ExcludeSemantics(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    points.first.label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: YronColors.textMuted,
                    ),
                  ),
                ),
                if (points.length > 1)
                  Expanded(
                    child: Text(
                      points.last.label,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: YronColors.textMuted,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StrengthTrendPainter extends CustomPainter {
  _StrengthTrendPainter({
    required this.points,
    required this.color,
    required this.textDirection,
  });

  final List<YronStrengthPoint> points;
  final Color color;
  final TextDirection textDirection;

  List<Offset> _positions(Size size) {
    final plot = Rect.fromLTWH(
      YronSpacing.sm,
      YronSpacing.sm,
      math.max(0, size.width - YronSpacing.md),
      math.max(0, size.height - YronSpacing.md),
    );
    // Scaling first avoids overflow when finite values span a very large range.
    final scale = points.fold<double>(
      1,
      (largest, point) => math.max(largest, point.value.abs()),
    );
    final values = points.map((point) => point.value / scale).toList();
    final low = values.reduce(math.min);
    final high = values.reduce(math.max);
    return [
      for (var index = 0; index < points.length; index++)
        Offset(
          points.length == 1
              ? plot.center.dx
              : plot.left + plot.width * index / (points.length - 1),
          high == low
              ? plot.center.dy
              : plot.bottom -
                    (values[index] - low) / (high - low) * plot.height,
        ),
    ];
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final positions = _positions(size);
    final grid = Paint()
      ..color = YronColors.outline
      ..strokeWidth = 1;
    for (var index = 0; index < 4; index++) {
      final y = YronSpacing.sm + (size.height - YronSpacing.md) * index / 3;
      canvas.drawLine(
        Offset(YronSpacing.sm, y),
        Offset(size.width - YronSpacing.sm, y),
        grid,
      );
    }
    final line = Path()..moveTo(positions.first.dx, positions.first.dy);
    for (final point in positions.skip(1)) {
      line.lineTo(point.dx, point.dy);
    }
    if (positions.length > 1) {
      final fill = Path.from(line)
        ..lineTo(positions.last.dx, size.height - YronSpacing.sm)
        ..lineTo(positions.first.dx, size.height - YronSpacing.sm)
        ..close();
      canvas.drawPath(
        fill,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color.withValues(alpha: 0.24),
              color.withValues(alpha: 0.01),
            ],
          ).createShader(Offset.zero & size),
      );
      canvas.drawPath(
        line,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round,
      );
    }
    for (final point in positions) {
      canvas.drawCircle(point, 4, Paint()..color = YronColors.surface);
      canvas.drawCircle(point, 3, Paint()..color = color);
    }
  }

  @override
  SemanticsBuilderCallback get semanticsBuilder => (size) {
    if (size.isEmpty) return const [];
    final positions = _positions(size);
    return [
      for (var index = 0; index < points.length; index++)
        CustomPainterSemantics(
          rect: Rect.fromCircle(
            center: positions[index],
            radius: 16,
          ).intersect(Offset.zero & size),
          properties: SemanticsProperties(
            label: points[index].semanticLabel,
            textDirection: textDirection,
            sortKey: OrdinalSortKey(index.toDouble()),
          ),
        ),
    ];
  };

  @override
  bool shouldRepaint(covariant _StrengthTrendPainter oldDelegate) {
    return color != oldDelegate.color ||
        !listEquals(points, oldDelegate.points);
  }

  @override
  bool shouldRebuildSemantics(covariant _StrengthTrendPainter oldDelegate) {
    return textDirection != oldDelegate.textDirection ||
        !listEquals(points, oldDelegate.points);
  }
}
