import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yron/main.dart';
import 'package:yron/features/program_creator/day_builder_screen.dart';
import 'package:yron_ui/yron_ui.dart';

Future<void> _launch(WidgetTester tester) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const MyApp());
}

Future<void> _openBuilder(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('create-program')));
  await tester.pumpAndSettle();
  await tester.tap(find.text('NEXT: CONFIGURE WEEKLY SPLIT'));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey('split-next')));
  await tester.pumpAndSettle();
}

Future<void> _startSampleProgram(WidgetTester tester) async {
  final preview = find.byKey(
    const ValueKey('template-preview-Push Pull Legs'),
  );
  await _scrollTo(tester, preview);
  await tester.tap(preview);
  await tester.pumpAndSettle();
  final start = find.text('START SAMPLE PROGRAM');
  await tester.ensureVisible(start);
  await tester.tap(start);
  await tester.pumpAndSettle();
}

Future<void> _scrollTo(WidgetTester tester, Finder target) async {
  await tester.scrollUntilVisible(
    target,
    250,
    scrollable: find
        .byWidgetPredicate(
          (widget) =>
              widget is Scrollable &&
              widget.axisDirection == AxisDirection.down,
        )
        .first,
    maxScrolls: 40,
  );
  await tester.pumpAndSettle();
}

Finder get _exerciseSearch => find.descendant(
  of: find.byKey(const ValueKey('exercise-search')),
  matching: find.byType(TextField),
);

void main() {
  testWidgets('empty tracker home and dashboard use shared UI', (tester) async {
    await _launch(tester);
    expect(find.text('IRON PULSE'), findsOneWidget);
    expect(find.text('NO ACTIVE PROGRAM'), findsOneWidget);
    expect(find.byType(YronBottomNavigation), findsOneWidget);
    expect(find.text('OR START FROM A PRESET'), findsOneWidget);
    await _scrollTo(tester, find.text('Push Pull Legs'));
    expect(find.text('Upper Lower'), findsOneWidget);
    expect(find.text('Arnold Split'), findsOneWidget);
    await tester.tap(
      find.byKey(const ValueKey('template-preview-Push Pull Legs')),
    );
    await tester.pumpAndSettle();
    expect(find.text('DAY 1'), findsOneWidget);
    final cancel = find.text('CANCEL');
    await tester.ensureVisible(cancel);
    await tester.tap(cancel);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dashboard'));
    await tester.pumpAndSettle();
    expect(find.text('PROGRESS'), findsOneWidget);
    expect(find.text('Total Volume'), findsOneWidget);
    expect(find.byType(YronStatCard), findsNWidgets(2));
    expect(find.byType(YronStrengthTrendChart), findsNWidgets(2));
    expect(find.text('BARBELL SQUAT'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('setup validates, preserves choices and saves a usable program', (
    tester,
  ) async {
    await _launch(tester);
    await tester.tap(find.byKey(const ValueKey('create-program')));
    await tester.pumpAndSettle();
    expect(find.text('1. PROGRAM SETUP'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).first, '');
    await tester.tap(find.text('NEXT: CONFIGURE WEEKLY SPLIT'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a program name to continue.'), findsOneWidget);
    await tester.enterText(
      find.byType(TextFormField).first,
      'MY LOCAL PROGRAM',
    );
    await _scrollTo(tester, find.byKey(const ValueKey('focus-strength')));
    await tester.tap(find.byKey(const ValueKey('focus-strength')));
    await _scrollTo(tester, find.byKey(const ValueKey('duration-12')));
    await tester.tap(find.byKey(const ValueKey('duration-12')));
    await tester.tap(find.text('NEXT: CONFIGURE WEEKLY SPLIT'));
    await tester.pumpAndSettle();
    expect(find.text('2. WEEKLY SPLIT'), findsOneWidget);
    expect(find.text('MY LOCAL PROGRAM · STRENGTH · 12 weeks'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('rest-day-0')));
    await tester.pump();
    expect(
      tester
          .widget<YronChoiceChip>(find.byKey(const ValueKey('rest-day-0')))
          .selected,
      isTrue,
    );
    await tester.tap(find.byKey(const ValueKey('workout-day-0')));
    await tester.tap(find.byKey(const ValueKey('split-next')));
    await tester.pumpAndSettle();
    expect(find.text('WORKOUT BUILDER'), findsOneWidget);
    expect(find.byType(YronProgramExerciseEditor), findsWidgets);
    await tester.tap(find.byKey(const ValueKey('builder-continue')));
    await tester.pumpAndSettle();
    expect(find.text('PROGRAM CREATOR'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('save-program')));
    await tester.pumpAndSettle();
    expect(find.text('MY LOCAL PROGRAM'), findsOneWidget);
    expect(find.text('WEEK 1 OF 12'), findsOneWidget);
    expect(find.text('Monday: Chest & Triceps'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('start-workout')));
    await tester.pumpAndSettle();
    expect(find.text('CHEST & TRICEPS'), findsOneWidget);
    expect(find.text('Barbell Bench Press'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('sample week selection logs sets and finishes into history', (
    tester,
  ) async {
    await _launch(tester);
    await _startSampleProgram(tester);
    expect(find.text('HYPERTROPHY PHASE II'), findsOneWidget);
    await tester.tap(find.byTooltip('Next week'));
    await tester.pump();
    expect(find.text('WEEK 2 OF 10'), findsOneWidget);
    await _scrollTo(tester, find.byKey(const ValueKey('choose-workout-day')));
    await tester.tap(find.byKey(const ValueKey('choose-workout-day')));
    await tester.pumpAndSettle();
    await _scrollTo(tester, find.text('Wednesday'));
    await tester.tap(find.text('Wednesday'));
    await tester.pump();
    await _scrollTo(tester, find.text('BACK TO PROGRAM'));
    expect(find.text('BACK TO PROGRAM'), findsOneWidget);
    await tester.drag(
      find
          .byWidgetPredicate(
            (widget) =>
                widget is Scrollable &&
                widget.axisDirection == AxisDirection.down,
          )
          .first,
      const Offset(0, 400),
    );
    await tester.pumpAndSettle();
    await _scrollTo(tester, find.text('Friday'));
    await tester.tap(find.text('Friday'));
    await tester.pump();
    await _scrollTo(tester, find.text('START SELECTED WORKOUT'));
    await tester.tap(find.text('START SELECTED WORKOUT'));
    await tester.pumpAndSettle();
    expect(find.text('SHOULDERS & ARMS HYPERTROPHY'), findsOneWidget);
    final row = find.byKey(const ValueKey('log-set-0-0'));
    await _scrollTo(tester, row);
    final inputs = find.descendant(
      of: row,
      matching: find.byType(TextFormField),
    );
    await tester.enterText(inputs.first, '55');
    await tester.enterText(inputs.last, '12');
    await tester.tap(find.descendant(of: row, matching: find.byType(Checkbox)));
    await tester.pump();
    expect(tester.widget<YronWorkoutSetRow>(row).completed, isTrue);
    await tester.tap(find.byKey(const ValueKey('finish-workout')));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.widgetWithText(TextButton, 'FINISH WORKOUT'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('HISTORY'), findsOneWidget);
    expect(find.text('1 set · 660 lbs'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('both picker variants select exercises; cancel changes nothing', (
    tester,
  ) async {
    await _launch(tester);
    await _openBuilder(tester);
    await _scrollTo(
      tester,
      find.byKey(const ValueKey('builder-add-exercises')),
    );
    await tester.tap(find.byKey(const ValueKey('builder-add-exercises')));
    await tester.pumpAndSettle();
    expect(find.text('Add Exercises to Monday'), findsOneWidget);
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.enterText(_exerciseSearch, 'Cable Chest Fly');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('exercise-cable-fly')));
    await tester.pump();
    expect(find.text('1 exercise selected'), findsOneWidget);
    tester.view.resetViewInsets();
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('confirm-exercises')));
    await tester.pumpAndSettle();
    await _scrollTo(tester, find.text('Cable Chest Fly'));
    expect(find.text('Cable Chest Fly'), findsOneWidget);
    await _scrollTo(tester, find.byKey(const ValueKey('builder-full-picker')));
    await tester.tap(find.byKey(const ValueKey('builder-full-picker')));
    await tester.pumpAndSettle();
    expect(find.text('SELECT EXERCISES'), findsOneWidget);
    await tester.enterText(_exerciseSearch, 'Lat Pulldown');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('exercise-lat-pulldown')));
    await tester.pump();
    await tester.tap(find.text('CANCEL'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<DayBuilderScreen>(find.byType(DayBuilderScreen))
          .draft
          .days
          .first
          .exercises
          .length,
      4,
    );
    await tester.tap(find.byKey(const ValueKey('builder-full-picker')));
    await tester.pumpAndSettle();
    await tester.enterText(_exerciseSearch, 'Lat Pulldown');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('exercise-lat-pulldown')));
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('confirm-exercises')));
    await tester.pumpAndSettle();
    await _scrollTo(tester, find.text('Lat Pulldown'));
    expect(find.text('Lat Pulldown'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('library search, filters and exercise detail are reachable', (
    tester,
  ) async {
    await _launch(tester);
    await tester.tap(find.byTooltip('Exercise library').first);
    await tester.pumpAndSettle();
    expect(find.text('EXERCISE LIBRARY'), findsOneWidget);
    expect(find.byKey(const ValueKey('equipment-filter')), findsOneWidget);
    expect(find.byKey(const ValueKey('difficulty-filter')), findsOneWidget);
    await tester.ensureVisible(find.byKey(const ValueKey('muscle-Chest')));
    await tester.tap(find.byKey(const ValueKey('muscle-Chest')));
    await tester.enterText(_exerciseSearch, 'Barbell');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('exercise-bench-press')));
    await tester.pumpAndSettle();
    expect(find.text('TECHNIQUE'), findsOneWidget);
    await tester.tap(find.text('DONE'));
    await tester.pumpAndSettle();
    expect(find.text('EXERCISE LIBRARY'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('builder validates prescriptions, reorders and deletes locally', (
    tester,
  ) async {
    await _launch(tester);
    await _openBuilder(tester);
    final editor = find.byType(YronProgramExerciseEditor).first;
    final fields = find.descendant(
      of: editor,
      matching: find.byType(TextFormField),
    );
    await tester.enterText(fields.first, '0');
    await tester.tap(find.byKey(const ValueKey('builder-continue')));
    await tester.pumpAndSettle();
    expect(find.text('Enter 1–20.'), findsOneWidget);
    expect(find.text('WORKOUT BUILDER'), findsOneWidget);
    await tester.enterText(fields.first, '4');
    await tester.enterText(fields.at(1), '8');
    await tester.enterText(fields.last, '120');
    tester.testTextInput.hide();
    await tester.pumpAndSettle();

    final moveDown = find.byTooltip('Move Barbell Bench Press down');
    await _scrollTo(tester, moveDown);
    await tester.tap(moveDown);
    await tester.pumpAndSettle();
    final draft = tester
        .widget<DayBuilderScreen>(find.byType(DayBuilderScreen))
        .draft;
    expect(draft.days.first.exercises[1].exercise.id, 'bench-press');
    expect(draft.days.first.exercises[1].sets, 4);
    expect(draft.days.first.exercises[1].reps, 8);
    expect(draft.days.first.exercises[1].restSeconds, 120);
    final delete = find.byTooltip('Delete Barbell Bench Press');
    await _scrollTo(tester, delete);
    await tester.tap(delete);
    await tester.pumpAndSettle();
    expect(draft.days.first.exercises.length, 2);
    expect(
      draft.days.first.exercises.any((e) => e.exercise.id == 'bench-press'),
      isFalse,
    );
    await _scrollTo(tester, find.byKey(const ValueKey('builder-preview')));
    await tester.tap(find.byKey(const ValueKey('builder-preview')));
    await tester.pumpAndSettle();
    expect(find.text('WORKOUT PREVIEW'), findsOneWidget);
    await tester.tap(find.text('BACK TO BUILDER'));
    await tester.pumpAndSettle();
    expect(find.text('WORKOUT BUILDER'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('unfinished workout back supports keep training and discard', (
    tester,
  ) async {
    await _launch(tester);
    await _startSampleProgram(tester);
    await _scrollTo(tester, find.byKey(const ValueKey('start-workout')));
    await tester.tap(find.byKey(const ValueKey('start-workout')));
    await tester.pumpAndSettle();
    final row = find.byKey(const ValueKey('log-set-0-0'));
    await _scrollTo(tester, row);
    await tester.tap(find.descendant(of: row, matching: find.byType(Checkbox)));
    await tester.pump();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Discard workout?'), findsOneWidget);
    await tester.tap(find.text('KEEP TRAINING'));
    await tester.pumpAndSettle();
    expect(find.text('ACTIVE WORKOUT'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('DISCARD'));
    await tester.pumpAndSettle();
    expect(find.text('TRACKER'), findsOneWidget);
    expect(find.text('ACTIVE WORKOUT'), findsNothing);
    await tester.tap(find.text('History'));
    await tester.pumpAndSettle();
    expect(find.text('No sessions logged'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tablet picker can cancel with the keyboard open', (
    tester,
  ) async {
    await _launch(tester);
    tester.view.physicalSize = const Size(1024, 1000);
    await tester.pumpAndSettle();
    await _openBuilder(tester);
    await _scrollTo(
      tester,
      find.byKey(const ValueKey('builder-add-exercises')),
    );
    await tester.tap(find.byKey(const ValueKey('builder-add-exercises')));
    await tester.pumpAndSettle();
    tester.view.viewInsets = const FakeViewPadding(bottom: 320);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpAndSettle();
    final bounds = tester.getRect(find.byType(YronExercisePicker));
    expect(bounds.width, lessThanOrEqualTo(720));
    await tester.enterText(_exerciseSearch, 'not an exercise');
    await tester.pumpAndSettle();
    expect(find.text('No matching exercises'), findsOneWidget);
    await tester.tap(find.text('CANCEL'));
    await tester.pumpAndSettle();
    expect(find.text('WORKOUT BUILDER'), findsOneWidget);
    expect(
      tester
          .widget<DayBuilderScreen>(find.byType(DayBuilderScreen))
          .draft
          .days
          .first
          .exercises
          .length,
      3,
    );
    expect(tester.takeException(), isNull);
  });
}
