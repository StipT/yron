import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yron/main.dart';
import 'package:yron_ui/yron_ui.dart';

void main() {
  testWidgets('renders the program setup screen and selection controls', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('1. PROGRAM SETUP'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('CYCLE SYNCHRONIZATION'),
      120,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('CYCLE SYNCHRONIZATION'), findsOneWidget);
    expect(
      tester
          .widget<YronChoiceChip>(
            find.byKey(const ValueKey('focus-hypertrophy')),
          )
          .selected,
      isTrue,
    );

    await tester.tap(find.byKey(const ValueKey('focus-strength')));
    await tester.pump();

    expect(
      tester
          .widget<YronChoiceChip>(find.byKey(const ValueKey('focus-strength')))
          .selected,
      isTrue,
    );

    await tester.tap(find.text('NEXT: CONFIGURE WEEKLY SPLIT'));
    await tester.pump();
    expect(
      find.text('Weekly split configuration is the next step.'),
      findsOneWidget,
    );
  });
}
