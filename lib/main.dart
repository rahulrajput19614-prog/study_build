import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const StudyBuildApp());
}

class StudyBuildApp extends StatelessWidget {
  const StudyBuildApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Build',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
