import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/navigation_controls_widget.dart';
import './widgets/question_display_widget.dart';
import './widgets/question_palette_widget.dart';
import './widgets/test_header_widget.dart';

class MockTestInterface extends StatefulWidget {
  const MockTestInterface({Key? key}) : super(key: key);

  @override
  State<MockTestInterface> createState() => _MockTestInterfaceState();
}

class _MockTestInterfaceState extends State<MockTestInterface>
    with WidgetsBindingObserver {
  // Test Configuration
  final String testName = "JEE Main Physics Mock Test 2024";
  final int testDurationMinutes = 180; // 3 hours

  // Test State
  int currentQuestionIndex = 0;
  Map<int, String> userAnswers = {};
  Set<int> markedQuestions = {};
  Timer? testTimer;
  int remainingTimeSeconds = 0;
  bool isTestPaused = false;
  bool showQuestionPalette = false;
  bool isTestSubmitted = false;

  // Mock Questions Data
  final List<Map<String, dynamic>> mockQuestions = [
    {
      "id": 1,
      "question":
          "A particle moves in a straight line with constant acceleration. If it covers 100m in the first 10 seconds and 150m in the next 10 seconds, what is its acceleration?",
      "options": ["2.5 m/s²", "5.0 m/s²", "7.5 m/s²", "10.0 m/s²"],
      "correctAnswer": "A",
      "image": null
    },
    {
      "id": 2,
      "question":
          "Which of the following statements about electromagnetic waves is correct?",
      "options": [
        "They require a medium to propagate",
        "They travel at the speed of light in vacuum",
        "They cannot be polarized",
        "They have only magnetic field components"
      ],
      "correctAnswer": "B",
      "image":
          "https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=500&h=300&fit=crop"
    },
    {
      "id": 3,
      "question":
          "A spring-mass system oscillates with simple harmonic motion. If the mass is doubled while keeping the spring constant same, the new time period will be:",
      "options": [
        "Same as before",
        "√2 times the original",
        "2 times the original",
        "Half the original"
      ],
      "correctAnswer": "B",
      "image": null
    },
    {
      "id": 4,
      "question":
          "In a photoelectric effect experiment, when light of frequency f falls on a metal surface, electrons are emitted with maximum kinetic energy K. If the frequency is doubled, the maximum kinetic energy becomes:",
      "options": ["2K", "K + hf", "2K + hf", "K + hf - φ"],
      "correctAnswer": "B",
      "image": null
    },
    {
      "id": 5,
      "question":
          "Two resistors of 4Ω and 6Ω are connected in parallel. What is the equivalent resistance?",
      "options": ["2.4Ω", "5.0Ω", "10.0Ω", "24.0Ω"],
      "correctAnswer": "A",
      "image": null
    },
    {
      "id": 6,
      "question":
          "A convex lens of focal length 20cm forms a real image at a distance of 30cm from the lens. What is the object distance?",
      "options": ["12cm", "60cm", "50cm", "15cm"],
      "correctAnswer": "B",
      "image":
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500&h=300&fit=crop"
    },
    {
      "id": 7,
      "question":
          "The de Broglie wavelength of an electron moving with velocity v is λ. If the velocity becomes 2v, the new wavelength will be:",
      "options": ["λ/2", "2λ", "λ/4", "4λ"],
      "correctAnswer": "A",
      "image": null
    },
    {
      "id": 8,
      "question":
          "In a uniform magnetic field, a charged particle moves in a circular path. If the charge is doubled and mass is halved, the radius of the path:",
      "options": [
        "Remains same",
        "Becomes half",
        "Becomes double",
        "Becomes one-fourth"
      ],
      "correctAnswer": "B",
      "image": null
    },
    {
      "id": 9,
      "question":
          "The work function of a metal is 2.5 eV. What is the threshold frequency for photoelectric emission?",
      "options": [
        "6.0 × 10¹⁴ Hz",
        "1.2 × 10¹⁵ Hz",
        "2.4 × 10¹⁵ Hz",
        "4.8 × 10¹⁵ Hz"
      ],
      "correctAnswer": "A",
      "image": null
    },
    {
      "id": 10,
      "question":
          "A transformer has 100 turns in primary and 200 turns in secondary. If the primary voltage is 220V, what is the secondary voltage?",
      "options": ["110V", "220V", "440V", "880V"],
      "correctAnswer": "C",
      "image": null
    }
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeTest();
    _preventScreenshots();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    testTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      if (!isTestPaused && !isTestSubmitted) {
        _pauseTest();
        _showBackgroundWarning();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (isTestPaused && !isTestSubmitted) {
        _resumeTest();
      }
    }
  }

  void _initializeTest() {
    remainingTimeSeconds = testDurationMinutes * 60;
    _startTimer();

    // Lock orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void _preventScreenshots() {
    // Prevent screenshots and screen recording
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _startTimer() {
    testTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isTestPaused && remainingTimeSeconds > 0) {
        setState(() {
          remainingTimeSeconds--;
        });

        // Auto-submit when time is up
        if (remainingTimeSeconds == 0) {
          _submitTest();
        }
      }
    });
  }

  void _pauseTest() {
    setState(() {
      isTestPaused = true;
    });
  }

  void _resumeTest() {
    setState(() {
      isTestPaused = false;
    });
  }

  void _showBackgroundWarning() {
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              CustomIconWidget(
                iconName: 'warning',
                color: AppTheme.lightTheme.colorScheme.error,
                size: 24,
              ),
              SizedBox(width: 2.w),
              Text('Test Paused'),
            ],
          ),
          content: Text(
            'The test has been paused because you switched to another app. Please stay in the test interface to continue.',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resumeTest();
              },
              child: Text('Resume Test'),
            ),
          ],
        ),
      );
    }
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  bool _isTimeWarning() {
    return remainingTimeSeconds <= 600; // Last 10 minutes
  }

  void _goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
      HapticFeedback.lightImpact();
    }
  }

  void _goToNextQuestion() {
    if (currentQuestionIndex < mockQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
      HapticFeedback.lightImpact();
    }
  }

  void _selectAnswer(String answer) {
    setState(() {
      userAnswers[currentQuestionIndex + 1] = answer;
    });
    HapticFeedback.selectionClick();
  }

  void _toggleMarkForReview() {
    setState(() {
      final questionNumber = currentQuestionIndex + 1;
      if (markedQuestions.contains(questionNumber)) {
        markedQuestions.remove(questionNumber);
      } else {
        markedQuestions.add(questionNumber);
      }
    });
    HapticFeedback.lightImpact();
  }

  void _goToQuestion(int questionNumber) {
    setState(() {
      currentQuestionIndex = questionNumber - 1;
      showQuestionPalette = false;
    });
    HapticFeedback.lightImpact();
  }

  void _toggleQuestionPalette() {
    setState(() {
      showQuestionPalette = !showQuestionPalette;
    });
  }

  void _submitTest() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'help_outline',
              color: AppTheme.lightTheme.primaryColor,
              size: 24,
            ),
            SizedBox(width: 2.w),
            Text('Submit Test'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to submit the test?',
              style: AppTheme.lightTheme.textTheme.bodyLarge,
            ),
            SizedBox(height: 2.h),
            Text(
              'Test Summary:',
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            Text('• Answered: ${userAnswers.length}/${mockQuestions.length}'),
            Text('• Marked for Review: ${markedQuestions.length}'),
            Text('• Time Remaining: ${_formatTime(remainingTimeSeconds)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _finalizeSubmission();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
            ),
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _finalizeSubmission() {
    setState(() {
      isTestSubmitted = true;
    });
    testTimer?.cancel();

    // Show success message and navigate
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'check_circle',
              color: AppTheme.lightTheme.colorScheme.tertiary,
              size: 24,
            ),
            SizedBox(width: 2.w),
            Text('Test Submitted'),
          ],
        ),
        content: Text(
          'Your test has been submitted successfully! You will be redirected to the results page.',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, '/home-screen');
            },
            child: Text('View Results'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isTestPaused) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: 'pause_circle_filled',
                color: Colors.white,
                size: 64,
              ),
              SizedBox(height: 2.h),
              Text(
                'Test Paused',
                style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                'Please return to the test interface',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final currentQuestion = mockQuestions[currentQuestionIndex];
    final currentQuestionNumber = currentQuestionIndex + 1;
    final selectedAnswer = userAnswers[currentQuestionNumber];
    final isMarkedForReview = markedQuestions.contains(currentQuestionNumber);
    final answeredQuestions = userAnswers.keys.toList();

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              // Test Header
              TestHeaderWidget(
                testName: testName,
                timeRemaining: _formatTime(remainingTimeSeconds),
                currentQuestion: currentQuestionNumber,
                totalQuestions: mockQuestions.length,
                isTimeWarning: _isTimeWarning(),
              ),

              // Question Display
              Expanded(
                child: SingleChildScrollView(
                  child: QuestionDisplayWidget(
                    question: currentQuestion,
                    selectedAnswer: selectedAnswer,
                    onAnswerSelected: _selectAnswer,
                  ),
                ),
              ),

              // Navigation Controls
              NavigationControlsWidget(
                canGoPrevious: currentQuestionIndex > 0,
                canGoNext: currentQuestionIndex < mockQuestions.length - 1,
                isLastQuestion:
                    currentQuestionIndex == mockQuestions.length - 1,
                isMarkedForReview: isMarkedForReview,
                onPrevious: _goToPreviousQuestion,
                onNext: _goToNextQuestion,
                onMarkForReview: _toggleMarkForReview,
                onSubmitTest: _submitTest,
              ),
            ],
          ),

          // Question Palette Overlay
          if (showQuestionPalette)
            Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: Center(
                child: QuestionPaletteWidget(
                  totalQuestions: mockQuestions.length,
                  currentQuestion: currentQuestionNumber,
                  answeredQuestions: answeredQuestions,
                  markedQuestions: markedQuestions.toList(),
                  onQuestionTap: _goToQuestion,
                  onClose: () => setState(() => showQuestionPalette = false),
                ),
              ),
            ),
        ],
      ),

      // Question Palette FAB
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleQuestionPalette,
        backgroundColor: AppTheme.lightTheme.primaryColor,
        child: CustomIconWidget(
          iconName: 'grid_view',
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
