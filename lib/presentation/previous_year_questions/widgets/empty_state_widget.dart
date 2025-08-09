import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyStateWidget extends StatelessWidget {
  final String subject;
  final VoidCallback? onRefresh;

  const EmptyStateWidget({
    Key? key,
    required this.subject,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Subject-specific illustration
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: _getSubjectColor(subject).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: _getSubjectIcon(subject),
                color: _getSubjectColor(subject),
                size: 60,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'No Questions Found',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              subject.isEmpty
                  ? 'Try adjusting your filters or search terms to find more questions.'
                  : 'More $subject questions coming soon!\nCheck back later for updates.',
              textAlign: TextAlign.center,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            SizedBox(height: 4.h),
            if (onRefresh != null)
              OutlinedButton.icon(
                onPressed: onRefresh,
                icon: CustomIconWidget(
                  iconName: 'refresh',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 20,
                ),
                label: Text('Refresh'),
              ),
          ],
        ),
      ),
    );
  }

  Color _getSubjectColor(String subject) {
    switch (subject.toLowerCase()) {
      case 'physics':
        return Colors.blue;
      case 'chemistry':
        return Colors.green;
      case 'mathematics':
        return Colors.purple;
      case 'biology':
        return Colors.orange;
      case 'history':
        return Colors.brown;
      case 'geography':
        return Colors.teal;
      case 'polity':
        return Colors.indigo;
      case 'economics':
        return Colors.red;
      default:
        return AppTheme.lightTheme.primaryColor;
    }
  }

  String _getSubjectIcon(String subject) {
    switch (subject.toLowerCase()) {
      case 'physics':
        return 'science';
      case 'chemistry':
        return 'biotech';
      case 'mathematics':
        return 'calculate';
      case 'biology':
        return 'local_florist';
      case 'history':
        return 'history_edu';
      case 'geography':
        return 'public';
      case 'polity':
        return 'account_balance';
      case 'economics':
        return 'trending_up';
      default:
        return 'quiz';
    }
  }
}
