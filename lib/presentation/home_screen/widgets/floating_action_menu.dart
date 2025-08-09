import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FloatingActionMenu extends StatelessWidget {
  final VoidCallback onGenerateStory;
  final VoidCallback onAddNote;
  final VoidCallback onStartQuiz;

  const FloatingActionMenu({
    super.key,
    required this.onGenerateStory,
    required this.onAddNote,
    required this.onStartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            'Quick Actions',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          _buildActionItem(
            context,
            'Generate Story',
            'Create AI-powered study stories',
            'auto_stories',
            AppTheme.lightTheme.colorScheme.secondary,
            onGenerateStory,
          ),
          SizedBox(height: 2.h),
          _buildActionItem(
            context,
            'Add Note',
            'Create a new study note',
            'note_add',
            AppTheme.lightTheme.colorScheme.primary,
            onAddNote,
          ),
          SizedBox(height: 2.h),
          _buildActionItem(
            context,
            'Start Quiz',
            'Begin a quick practice quiz',
            'quiz',
            AppTheme.lightTheme.colorScheme.tertiary,
            onStartQuiz,
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context,
    String title,
    String subtitle,
    String iconName,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomIconWidget(
                iconName: iconName,
                color: color,
                size: 24,
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    subtitle,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            CustomIconWidget(
              iconName: 'arrow_forward_ios',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
