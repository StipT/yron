import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import 'features/program_setup/create_program_setup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iron Progress',
      debugShowCheckedModeBanner: false,
      theme: buildYronTheme(),
      home: const CreateProgramSetupScreen(),
    );
  }
}
