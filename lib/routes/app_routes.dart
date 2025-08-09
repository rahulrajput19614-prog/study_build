import 'package:flutter/material.dart';
import '../presentation/notes_management/notes_management.dart';
import '../presentation/user_profile/user_profile.dart';
import '../presentation/mock_test_interface/mock_test_interface.dart';
import '../presentation/previous_year_questions/previous_year_questions.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/sign_up_screen/sign_up_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String notesManagement = '/notes-management';
  static const String userProfile = '/user-profile';
  static const String mockTestInterface = '/mock-test-interface';
  static const String previousYearQuestions = '/previous-year-questions';
  static const String home = '/home-screen';
  static const String signUp = '/sign-up-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const NotesManagement(),
    notesManagement: (context) => const NotesManagement(),
    userProfile: (context) => const UserProfile(),
    mockTestInterface: (context) => const MockTestInterface(),
    previousYearQuestions: (context) => const PreviousYearQuestions(),
    home: (context) => const HomeScreen(),
    signUp: (context) => const SignUpScreen(),
    // TODO: Add your other routes here
  };
}
