import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/exam_selection_widget.dart';
import './widgets/password_strength_widget.dart';
import './widgets/social_signup_widget.dart';
import './widgets/terms_checkbox_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Text controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Focus nodes
  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  // Form state
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isTermsAccepted = false;
  bool _isLoading = false;
  String? _selectedExam;

  // Animation controllers
  late AnimationController _progressController;
  late AnimationController _successController;
  late Animation<double> _progressAnimation;
  late Animation<double> _successAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _setupKeyboardListener();
  }

  void _initializeAnimations() {
    _progressController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _successController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _successAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _successController,
      curve: Curves.elasticOut,
    ));
  }

  void _setupKeyboardListener() {
    _fullNameFocus.addListener(_updateProgress);
    _emailFocus.addListener(_updateProgress);
    _passwordFocus.addListener(_updateProgress);
    _confirmPasswordFocus.addListener(_updateProgress);
  }

  void _updateProgress() {
    double progress = 0.0;

    if (_fullNameController.text.isNotEmpty) progress += 0.2;
    if (_emailController.text.isNotEmpty &&
        _isValidEmail(_emailController.text)) progress += 0.2;
    if (_passwordController.text.isNotEmpty &&
        _passwordController.text.length >= 8) progress += 0.2;
    if (_confirmPasswordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text)
      progress += 0.2;
    if (_selectedExam != null) progress += 0.1;
    if (_isTermsAccepted) progress += 0.1;

    _progressController.animateTo(progress);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isFormValid() {
    return _fullNameController.text.isNotEmpty &&
        _isValidEmail(_emailController.text) &&
        _passwordController.text.length >= 8 &&
        _passwordController.text == _confirmPasswordController.text &&
        _selectedExam != null &&
        _isTermsAccepted;
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate() || !_isFormValid()) {
      _showErrorMessage('Please fill all fields correctly');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // Show success animation
      await _successController.forward();

      // Navigate to home screen
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home-screen');
      }
    } catch (e) {
      _showErrorMessage('Registration failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleGoogleSignup() async {
    setState(() => _isLoading = true);

    try {
      // Simulate Google signup
      await Future.delayed(Duration(seconds: 1));

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home-screen');
      }
    } catch (e) {
      _showErrorMessage('Google signup failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleAppleSignup() async {
    setState(() => _isLoading = true);

    try {
      // Simulate Apple signup
      await Future.delayed(Duration(seconds: 1));

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home-screen');
      }
    } catch (e) {
      _showErrorMessage('Apple signup failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(4.w),
      ),
    );
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Terms of Service'),
        content: SingleChildScrollView(
          child: Text(
            'Welcome to Study Build! By creating an account, you agree to our terms of service. We are committed to providing you with the best educational experience while protecting your privacy and data.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Privacy Policy'),
        content: SingleChildScrollView(
          child: Text(
            'Your privacy is important to us. We collect and use your information to provide personalized study content and track your learning progress. We do not share your personal information with third parties without your consent.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _progressController.dispose();
    _successController.dispose();
    _scrollController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with progress
            _buildHeader(),

            // Form content
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),

                      // Welcome text
                      _buildWelcomeSection(),

                      SizedBox(height: 4.h),

                      // Form fields
                      _buildFormFields(),

                      SizedBox(height: 3.h),

                      // Exam selection
                      _buildExamSelection(),

                      SizedBox(height: 3.h),

                      // Terms checkbox
                      _buildTermsSection(),

                      SizedBox(height: 4.h),

                      // Sign up button
                      _buildSignUpButton(),

                      SizedBox(height: 4.h),

                      // Social signup
                      _buildSocialSignup(),

                      SizedBox(height: 3.h),

                      // Login link
                      _buildLoginLink(),

                      SizedBox(height: 4.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: 'arrow_back',
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 5.w,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 2.h),
          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return Container(
                width: double.infinity,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _progressAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Join Study Build',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Create your account to access AI-powered study materials, mock tests, and personalized learning paths.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        // Full Name
        TextFormField(
          controller: _fullNameController,
          focusNode: _fullNameFocus,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          onChanged: (_) => _updateProgress(),
          decoration: InputDecoration(
            labelText: 'Full Name',
            hintText: 'Enter your full name',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'person',
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 5.w,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your full name';
            }
            if (value.trim().length < 2) {
              return 'Name must be at least 2 characters';
            }
            return null;
          },
        ),

        SizedBox(height: 2.h),

        // Email
        TextFormField(
          controller: _emailController,
          focusNode: _emailFocus,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          onChanged: (_) => _updateProgress(),
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'Enter your email',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'email',
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 5.w,
              ),
            ),
            suffixIcon: _emailController.text.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: _isValidEmail(_emailController.text)
                          ? 'check_circle'
                          : 'error',
                      color: _isValidEmail(_emailController.text)
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.error,
                      size: 5.w,
                    ),
                  )
                : null,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your email';
            }
            if (!_isValidEmail(value.trim())) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),

        SizedBox(height: 2.h),

        // Password
        TextFormField(
          controller: _passwordController,
          focusNode: _passwordFocus,
          textInputAction: TextInputAction.next,
          obscureText: !_isPasswordVisible,
          onChanged: (_) => _updateProgress(),
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Create a strong password',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'lock',
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 5.w,
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: () =>
                  setState(() => _isPasswordVisible = !_isPasswordVisible),
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName:
                      _isPasswordVisible ? 'visibility_off' : 'visibility',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 5.w,
                ),
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            if (value.length < 8) {
              return 'Password must be at least 8 characters';
            }
            return null;
          },
        ),

        // Password strength indicator
        PasswordStrengthWidget(password: _passwordController.text),

        SizedBox(height: 2.h),

        // Confirm Password
        TextFormField(
          controller: _confirmPasswordController,
          focusNode: _confirmPasswordFocus,
          textInputAction: TextInputAction.done,
          obscureText: !_isConfirmPasswordVisible,
          onChanged: (_) => _updateProgress(),
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            hintText: 'Re-enter your password',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'lock',
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 5.w,
              ),
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_confirmPasswordController.text.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: CustomIconWidget(
                      iconName: _passwordController.text ==
                              _confirmPasswordController.text
                          ? 'check_circle'
                          : 'error',
                      color: _passwordController.text ==
                              _confirmPasswordController.text
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.error,
                      size: 5.w,
                    ),
                  ),
                GestureDetector(
                  onTap: () => setState(() =>
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                  child: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: _isConfirmPasswordVisible
                          ? 'visibility_off'
                          : 'visibility',
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 5.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != _passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildExamSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Target Exam',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 1.h),
        ExamSelectionWidget(
          selectedExam: _selectedExam,
          onExamSelected: (exam) {
            setState(() => _selectedExam = exam);
            _updateProgress();
          },
        ),
      ],
    );
  }

  Widget _buildTermsSection() {
    return TermsCheckboxWidget(
      isAccepted: _isTermsAccepted,
      onChanged: (value) {
        setState(() => _isTermsAccepted = value ?? false);
        _updateProgress();
      },
      onTermsTap: _showTermsDialog,
      onPrivacyTap: _showPrivacyDialog,
    );
  }

  Widget _buildSignUpButton() {
    return AnimatedBuilder(
      animation: _successAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_successAnimation.value * 0.1),
          child: SizedBox(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton(
              onPressed: _isLoading || !_isFormValid() ? null : _handleSignUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFormValid()
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                foregroundColor: _isFormValid()
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              child: _isLoading
                  ? SizedBox(
                      width: 5.w,
                      height: 5.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      'Create Account',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: _isFormValid()
                                ? Colors.white
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialSignup() {
    return SocialSignupWidget(
      onGoogleSignup: _handleGoogleSignup,
      onAppleSignup: _handleAppleSignup,
    );
  }

  Widget _buildLoginLink() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
