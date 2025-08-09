import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DailyGoalCard extends StatelessWidget {
  final int currentStreak;
  final double progressPercentage;
  final String motivationalMessage;

  const DailyGoalCard({
    super.key,
    required this.currentStreak,
    required this.progressPercentage,
    required this.motivationalMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.lightTheme.colorScheme.primary,
            AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Study Goal',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  motivationalMessage,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'local_fire_department',
                      color: Colors.orange,
                      size: 20,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '$currentStreak day streak',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: Stack(
                    children: [
                      CircularProgressIndicator(
                        value: progressPercentage / 100,
                        strokeWidth: 6,
                        backgroundColor: Colors.white.withValues(alpha: 0.3),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      Center(
                        child: Text(
                          '${progressPercentage.toInt()}%',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Complete',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
