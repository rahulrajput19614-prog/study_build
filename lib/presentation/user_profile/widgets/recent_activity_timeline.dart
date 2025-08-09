import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecentActivityTimeline extends StatelessWidget {
  final List<Map<String, dynamic>> activities;

  const RecentActivityTimeline({
    Key? key,
    required this.activities,
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
            'Recent Activity',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 3.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            separatorBuilder: (context, index) => SizedBox(height: 2.h),
            itemBuilder: (context, index) {
              final activity = activities[index];
              return _buildActivityItem(
                icon: activity['icon'] as String,
                title: activity['title'] as String,
                description: activity['description'] as String,
                timestamp: activity['timestamp'] as String,
                color: _getActivityColor(activity['type'] as String),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required String icon,
    required String title,
    required String description,
    required String timestamp,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: icon,
              color: color,
              size: 5.w,
            ),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                description,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                timestamp,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                      .withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case 'test':
        return AppTheme.lightTheme.colorScheme.primary;
      case 'story':
        return AppTheme.lightTheme.colorScheme.secondary;
      case 'study':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'achievement':
        return Colors.orange;
      default:
        return AppTheme.lightTheme.colorScheme.primary;
    }
  }
}
