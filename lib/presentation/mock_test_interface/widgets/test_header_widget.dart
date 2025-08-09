import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TestHeaderWidget extends StatelessWidget {
  final String testName;
  final String timeRemaining;
  final int currentQuestion;
  final int totalQuestions;
  final bool isTimeWarning;

  const TestHeaderWidget({
    Key? key,
    required this.testName,
    required this.timeRemaining,
    required this.currentQuestion,
    required this.totalQuestions,
    this.isTimeWarning = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Test Name
            Text(
              testName,
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.primaryColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 1.h),

            // Timer and Question Counter Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Timer
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: isTimeWarning
                        ? AppTheme.lightTheme.colorScheme.error
                            .withValues(alpha: 0.1)
                        : AppTheme.lightTheme.primaryColor
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isTimeWarning
                          ? AppTheme.lightTheme.colorScheme.error
                          : AppTheme.lightTheme.primaryColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'timer',
                        color: isTimeWarning
                            ? AppTheme.lightTheme.colorScheme.error
                            : AppTheme.lightTheme.primaryColor,
                        size: 18,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        timeRemaining,
                        style:
                            AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                          color: isTimeWarning
                              ? AppTheme.lightTheme.colorScheme.error
                              : AppTheme.lightTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Question Counter
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.secondary
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.secondary,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'quiz',
                        color: AppTheme.lightTheme.colorScheme.secondary,
                        size: 18,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '$currentQuestion / $totalQuestions',
                        style:
                            AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
