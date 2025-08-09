import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NavigationControlsWidget extends StatelessWidget {
  final bool canGoPrevious;
  final bool canGoNext;
  final bool isLastQuestion;
  final bool isMarkedForReview;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final VoidCallback onMarkForReview;
  final VoidCallback? onSubmitTest;

  const NavigationControlsWidget({
    Key? key,
    required this.canGoPrevious,
    required this.canGoNext,
    required this.isLastQuestion,
    required this.isMarkedForReview,
    this.onPrevious,
    this.onNext,
    required this.onMarkForReview,
    this.onSubmitTest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Mark for Review Button
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 2.h),
              child: OutlinedButton.icon(
                onPressed: onMarkForReview,
                icon: CustomIconWidget(
                  iconName: isMarkedForReview ? 'bookmark' : 'bookmark_border',
                  color: isMarkedForReview
                      ? AppTheme.warningLight
                      : AppTheme.lightTheme.colorScheme.outline,
                  size: 20,
                ),
                label: Text(
                  isMarkedForReview ? 'Marked for Review' : 'Mark for Review',
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: isMarkedForReview
                        ? AppTheme.warningLight
                        : AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  side: BorderSide(
                    color: isMarkedForReview
                        ? AppTheme.warningLight
                        : AppTheme.lightTheme.colorScheme.outline,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            // Navigation Buttons Row
            Row(
              children: [
                // Previous Button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: canGoPrevious ? onPrevious : null,
                    icon: CustomIconWidget(
                      iconName: 'arrow_back',
                      color:
                          canGoPrevious ? Colors.white : Colors.grey.shade400,
                      size: 20,
                    ),
                    label: Text(
                      'Previous',
                      style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                        color:
                            canGoPrevious ? Colors.white : Colors.grey.shade400,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: canGoPrevious
                          ? AppTheme.lightTheme.colorScheme.secondary
                          : Colors.grey.shade300,
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      elevation: canGoPrevious ? 2 : 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 3.w),

                // Next/Submit Button
                Expanded(
                  flex: isLastQuestion ? 2 : 1,
                  child: ElevatedButton.icon(
                    onPressed: isLastQuestion
                        ? onSubmitTest
                        : (canGoNext ? onNext : null),
                    icon: CustomIconWidget(
                      iconName:
                          isLastQuestion ? 'check_circle' : 'arrow_forward',
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      isLastQuestion ? 'Submit Test' : 'Next',
                      style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight:
                            isLastQuestion ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLastQuestion
                          ? AppTheme.lightTheme.colorScheme.tertiary
                          : AppTheme.lightTheme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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
