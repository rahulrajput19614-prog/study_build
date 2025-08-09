import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class UserAvatarSection extends StatelessWidget {
  final String userName;
  final String selectedExam;
  final int studyStreak;
  final String avatarUrl;
  final VoidCallback onAvatarTap;

  const UserAvatarSection({
    Key? key,
    required this.userName,
    required this.selectedExam,
    required this.studyStreak,
    required this.avatarUrl,
    required this.onAvatarTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
            AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onAvatarTap,
            child: Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: CustomImageWidget(
                  imageUrl: avatarUrl,
                  width: 20.w,
                  height: 20.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            userName,
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Text(
              selectedExam,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: 'local_fire_department',
                color: Colors.orange,
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              Text(
                '$studyStreak Day Streak',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
