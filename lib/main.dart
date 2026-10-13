import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import 'features/dashboard/progress_dashboard_screen.dart';
import 'features/exercise_library/exercise_library_screen.dart';
import 'features/history/history_screen.dart';
import 'features/program_creator/program_draft.dart';
import 'features/program_setup/create_program_setup_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/tracker/active_program_screen.dart';
import 'features/tracker/active_workout_screen.dart';
import 'features/tracker/tracker_empty_screen.dart';
import 'features/tracker/workout_sample.dart';
import 'l10n/gen/app_localizations.dart';
import 'l10n/l10n.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => context.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      theme: buildYronTheme(),
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: IronProgressHome(
        locale: _locale,
        onLocaleChanged: (locale) => setState(() => _locale = locale),
      ),
    );
  }
}

class IronProgressHome extends StatefulWidget {
  const IronProgressHome({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
  });

  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<IronProgressHome> createState() => _IronProgressHomeState();
}

class _IronProgressHomeState extends State<IronProgressHome> {
  int _tab = 0;
  bool _sampleProgramActive = false;
  ProgramDraft? _program;
  final List<WorkoutSessionSummary> _sessions = [];

  void _createProgram() {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => CreateProgramSetupScreen(
          onProgramSaved: (draft) => setState(() {
            _program = draft;
            _tab = 0;
          }),
        ),
      ),
    );
  }

  void _openLibrary() {
    Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (_) => const ExerciseLibraryScreen()),
    );
  }

  Future<void> _startWorkout(WorkoutSample workout) async {
    final summary = await Navigator.push<WorkoutSessionSummary>(
      context,
      MaterialPageRoute(builder: (_) => ActiveWorkoutScreen(workout: workout)),
    );
    if (!mounted || summary == null) return;
    Navigator.popUntil(context, (route) => route.isFirst);
    setState(() {
      _sessions.add(summary);
      _tab = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: [
          if (_sampleProgramActive || _program != null)
            ActiveProgramScreen(
              key: ValueKey(_program),
              program: _program,
              onStartWorkout: _startWorkout,
              onCreateProgram: _createProgram,
              onLibrary: _openLibrary,
            )
          else
            TrackerEmptyScreen(
              onCreateProgram: _createProgram,
              onStartSample: () => setState(() => _sampleProgramActive = true),
              onLibrary: _openLibrary,
            ),
          const ProgressDashboardScreen(),
          HistoryScreen(sessions: _sessions),
          SettingsScreen(
            onLibrary: _openLibrary,
            onCreateProgram: _createProgram,
            selectedLocale: widget.locale,
            onLocaleChanged: widget.onLocaleChanged,
          ),
        ],
      ),
      bottomNavigationBar: YronBottomNavigation(
        items: [
          YronNavigationItem(label: l10n.navTracker, icon: Icons.edit_note),
          YronNavigationItem(
            label: l10n.navDashboard,
            icon: Icons.dashboard_outlined,
            selectedIcon: Icons.dashboard,
          ),
          YronNavigationItem(
            label: l10n.navHistory,
            icon: Icons.calendar_today_outlined,
          ),
          YronNavigationItem(
            label: l10n.navSettings,
            icon: Icons.settings_outlined,
          ),
        ],
        selectedIndex: _tab,
        onSelected: (index) => setState(() => _tab = index),
      ),
    );
  }
}
