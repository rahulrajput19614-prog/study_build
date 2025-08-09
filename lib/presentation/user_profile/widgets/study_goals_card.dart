import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class StudyGoalsCard extends StatelessWidget {
  final int dailyGoal;
  final int currentProgress;
  final String motivationalMessage;
  final VoidCallback onSetGoal;

  const StudyGoalsCard({
    Key? key,
    required this.dailyGoal,
    required this.currentProgress,
    required this.motivationalMessage,
    required this.onSetGoal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = dailyGoal > 0 ? currentProgress / dailyGoal : 0.0;
    if (progress > 1.0) progress = 1.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Study Goals',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
              ),
              IconButton(
                onPressed: onSetGoal,
                icon: CustomIconWidget(
                  iconName: 'edit',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 5.w,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.lightTheme.colorScheme.tertiary
                      .withValues(alpha: 0.1),
                  AppTheme.lightTheme.colorScheme.primary
                      .withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Daily Target',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      '$currentProgress / $dailyGoal minutes',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightTheme.colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.lightTheme.colorScheme.tertiary,
                  ),
                  minHeight: 1.h,
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: progress >= 1.0 ? 'check_circle' : 'schedule',
                      color: progress >= 1.0
                          ? AppTheme.lightTheme.colorScheme.tertiary
                          : AppTheme.lightTheme.colorScheme.primary,
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        progress >= 1.0
                            ? 'Goal achieved! Great job! 🎉'
                            : motivationalMessage,
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: progress >= 1.0
                              ? AppTheme.lightTheme.colorScheme.tertiary
                              : AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: _buildGoalStat(
                  icon: 'trending_up',
                  title: 'Progress',
                  value: '${(progress * 100).toInt()}%',
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildGoalStat(
                  icon: 'timer',
                  title: 'Remaining',
                  value: '${dailyGoal - currentProgress}m',
                  color: AppTheme.lightTheme.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoalStat({
    required String icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: icon,
            color: color,
            size: 5.w,
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
