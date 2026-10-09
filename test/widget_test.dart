import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yron/main.dart';
import 'package:yron_ui/yron_ui.dart';

void main() {
  testWidgets('renders the progress dashboard', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('PROGRESS'), findsOneWidget);
    expect(find.text('Total Volume'), findsOneWidget);
    expect(find.text('124.5k lbs'), findsOneWidget);
    expect(find.text('STRENGTH GAINS'), findsOneWidget);
    expect(find.text('BARBELL SQUAT'), findsOneWidget);
    expect(find.text('Dashboard'), findsOneWidget);
  });

  testWidgets('saved program is retained and opened from tracker', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tracker'));
    await tester.pumpAndSettle();

    expect(find.text('1. PROGRAM SETUP'), findsOneWidget);
    await tester.enterText(
      find.byKey(const ValueKey('program-name')),
      'My Edited Program',
    );
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
    await tester.pumpAndSettle();
    expect(
      find.text('My Edited Program · STRENGTH · 10 weeks'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const ValueKey('split-next')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('workout-title-0')),
      'Edited Chest Day',
    );
    await tester.tap(find.byKey(const ValueKey('builder-continue')));
    await tester.pumpAndSettle();
    expect(find.text('My Edited Program'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('save-program')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tracker'));
    await tester.pumpAndSettle();

    expect(find.text('My Edited Program'), findsOneWidget);
    expect(find.text('Edited Chest Day'), findsOneWidget);
    expect(find.text('STRENGTH'), findsOneWidget);
  });
}
