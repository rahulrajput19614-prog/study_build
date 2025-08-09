import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickActionItem extends StatelessWidget {
  final String title;
  final String iconName;
  final Color backgroundColor;
  final VoidCallback onTap;

  const QuickActionItem({
    super.key,
    required this.title,
    required this.iconName,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: backgroundColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: backgroundColor.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: backgroundColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomIconWidget(
                iconName: iconName,
                color: backgroundColor,
                size: 24,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color: backgroundColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
