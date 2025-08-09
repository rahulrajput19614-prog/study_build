import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class PasswordStrengthWidget extends StatelessWidget {
  final String password;

  const PasswordStrengthWidget({
    Key? key,
    required this.password,
  }) : super(key: key);

  Map<String, dynamic> _calculatePasswordStrength(String password) {
    if (password.isEmpty) {
      return {
        'strength': 0,
        'label': 'Enter password',
        'color': Colors.grey,
        'progress': 0.0,
      };
    }

    int score = 0;
    List<String> requirements = [];

    // Length check
    if (password.length >= 8) {
      score += 2;
    } else {
      requirements.add('At least 8 characters');
    }

    // Uppercase check
    if (password.contains(RegExp(r'[A-Z]'))) {
      score += 1;
    } else {
      requirements.add('One uppercase letter');
    }

    // Lowercase check
    if (password.contains(RegExp(r'[a-z]'))) {
      score += 1;
    } else {
      requirements.add('One lowercase letter');
    }

    // Number check
    if (password.contains(RegExp(r'[0-9]'))) {
      score += 1;
    } else {
      requirements.add('One number');
    }

    // Special character check
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      score += 1;
    } else {
      requirements.add('One special character');
    }

    String label;
    Color color;
    double progress;

    if (score <= 2) {
      label = 'Weak';
      color = AppTheme.lightTheme.colorScheme.error;
      progress = 0.25;
    } else if (score <= 4) {
      label = 'Fair';
      color = Colors.orange;
      progress = 0.5;
    } else if (score <= 5) {
      label = 'Good';
      color = Colors.blue;
      progress = 0.75;
    } else {
      label = 'Strong';
      color = AppTheme.lightTheme.colorScheme.tertiary;
      progress = 1.0;
    }

    return {
      'strength': score,
      'label': label,
      'color': color,
      'progress': progress,
      'requirements': requirements,
    };
  }

  @override
  Widget build(BuildContext context) {
    final strengthData = _calculatePasswordStrength(password);

    return password.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 0.5.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: strengthData['progress'],
                        child: Container(
                          decoration: BoxDecoration(
                            color: strengthData['color'],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    strengthData['label'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: strengthData['color'],
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              if ((strengthData['requirements'] as List).isNotEmpty) ...[
                SizedBox(height: 1.h),
                Wrap(
                  spacing: 2.w,
                  runSpacing: 0.5.h,
                  children: (strengthData['requirements'] as List<String>)
                      .map((requirement) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .errorContainer
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .error
                              .withValues(alpha: 0.3),
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        requirement,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          )
        : SizedBox.shrink();
  }
}
