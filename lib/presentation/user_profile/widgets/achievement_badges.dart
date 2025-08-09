import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AchievementBadges extends StatelessWidget {
  final int testsCompleted;
  final int storiesGenerated;
  final int studyDays;

  const AchievementBadges({
    Key? key,
    required this.testsCompleted,
    required this.storiesGenerated,
    required this.studyDays,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Text(
            'Achievements',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: _buildAchievementCard(
                  icon: 'quiz',
                  title: 'Tests',
                  current: testsCompleted,
                  target: 50,
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildAchievementCard(
                  icon: 'auto_stories',
                  title: 'Stories',
                  current: storiesGenerated,
                  target: 25,
                  color: AppTheme.lightTheme.colorScheme.secondary,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildAchievementCard(
                  icon: 'calendar_today',
                  title: 'Days',
                  current: studyDays,
                  target: 100,
                  color: AppTheme.lightTheme.colorScheme.tertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard({
    required String icon,
    required String title,
    required int current,
    required int target,
    required Color color,
  }) {
    double progress = current / target;
    if (progress > 1.0) progress = 1.0;

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: icon,
            color: color,
            size: 6.w,
          ),
          SizedBox(height: 1.h),
          Text(
            current.toString(),
            style: TextStyle(
              fontSize: 16.sp,
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
          SizedBox(height: 1.h),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 0.5.h,
          ),
          SizedBox(height: 0.5.h),
          Text(
            '${(progress * 100).toInt()}%',
            style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
