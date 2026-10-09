import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import 'features/dashboard/progress_dashboard_screen.dart';
import 'features/program_creator/program_creator_screen.dart';
import 'features/program_creator/program_draft.dart';
import 'features/program_setup/create_program_setup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ProgramDraft? _activeProgram;

  void _onProgramSaved(ProgramDraft draft) {
    setState(() => _activeProgram = draft);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iron Progress',
      debugShowCheckedModeBanner: false,
      theme: buildYronTheme(),
      home: Builder(
        builder: (context) => ProgressDashboardScreen(
          onTrackerSelected: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) {
                  final activeProgram = _activeProgram;
                  if (activeProgram != null) {
                    return ProgramCreatorScreen(
                      draft: activeProgram,
                      onProgramSaved: _onProgramSaved,
                    );
                  }
                  return CreateProgramSetupScreen(
                    onProgramSaved: _onProgramSaved,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
