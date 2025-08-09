import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecentActivityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String type;
  final String timestamp;
  final VoidCallback? onTap;

  const RecentActivityCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.timestamp,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70.w,
        margin: EdgeInsets.only(right: 3.w),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: _getTypeColor(type).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    type,
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                      color: _getTypeColor(type),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                CustomIconWidget(
                  iconName: _getTypeIcon(type),
                  color: _getTypeColor(type),
                  size: 16,
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 1.h),
            Text(
              subtitle,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            Text(
              timestamp,
              style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                    .withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'story':
        return AppTheme.lightTheme.colorScheme.secondary;
      case 'test':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'note':
        return AppTheme.lightTheme.colorScheme.primary;
      default:
        return AppTheme.lightTheme.colorScheme.primary;
    }
  }

  String _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'story':
        return 'auto_stories';
      case 'test':
        return 'quiz';
      case 'note':
        return 'note';
      default:
        return 'article';
    }
  }
}
