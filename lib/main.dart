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

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iron Progress',
      debugShowCheckedModeBanner: false,
      theme: buildYronTheme(),
      home: const IronProgressHome(),
    );
  }
}

class IronProgressHome extends StatefulWidget {
  const IronProgressHome({super.key});

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
          ),
        ],
      ),
      bottomNavigationBar: YronBottomNavigation(
        items: const [
          YronNavigationItem(label: 'Tracker', icon: Icons.edit_note),
          YronNavigationItem(
            label: 'Dashboard',
            icon: Icons.dashboard_outlined,
            selectedIcon: Icons.dashboard,
          ),
          YronNavigationItem(
            label: 'History',
            icon: Icons.calendar_today_outlined,
          ),
          YronNavigationItem(label: 'Settings', icon: Icons.settings_outlined),
        ],
        selectedIndex: _tab,
        onSelected: (index) => setState(() => _tab = index),
      ),
    );
  }
}
