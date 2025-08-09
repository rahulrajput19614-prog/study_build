import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuestionCard extends StatelessWidget {
  final Map<String, dynamic> question;
  final VoidCallback onTap;
  final VoidCallback onBookmark;
  final VoidCallback onPractice;
  final VoidCallback onAddToTest;

  const QuestionCard({
    Key? key,
    required this.question,
    required this.onTap,
    required this.onBookmark,
    required this.onPractice,
    required this.onAddToTest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAttempted = question['isAttempted'] ?? false;
    final bool isBookmarked = question['isBookmarked'] ?? false;
    final bool isIncorrect = question['isIncorrect'] ?? false;
    final String difficulty = question['difficulty'] ?? 'Medium';
    final String subject = question['subject'] ?? '';
    final String year = question['year']?.toString() ?? '';
    final String questionText = question['questionText'] ?? '';
    final List<String> topics =
        (question['topics'] as List?)?.cast<String>() ?? [];
    final int attempts = question['attempts'] ?? 0;

    return Dismissible(
      key: Key(question['id'].toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(width: 6.w),
            CustomIconWidget(
              iconName: 'bookmark',
              color: AppTheme.lightTheme.primaryColor,
              size: 24,
            ),
            SizedBox(width: 2.w),
            Text(
              'Bookmark',
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.lightTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            CustomIconWidget(
              iconName: 'play_circle_outline',
              color: AppTheme.lightTheme.colorScheme.secondary,
              size: 24,
            ),
            SizedBox(width: 2.w),
            Text(
              'Practice',
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 6.w),
          ],
        ),
      ),
      onDismissed: (direction) {
        onBookmark();
      },
      child: GestureDetector(
        onTap: onTap,
        onLongPress: () => _showContextMenu(context),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.colorScheme.shadow
                    .withValues(alpha: 0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with subject icon and status indicators
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: _getSubjectColor(subject).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomIconWidget(
                      iconName: _getSubjectIcon(subject),
                      color: _getSubjectColor(subject),
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject,
                          style: AppTheme.lightTheme.textTheme.titleSmall
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          year,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Status indicators
                  Row(
                    children: [
                      if (isAttempted)
                        Container(
                          margin: EdgeInsets.only(right: 1.w),
                          child: CustomIconWidget(
                            iconName: 'check_circle',
                            color: AppTheme.lightTheme.colorScheme.tertiary,
                            size: 16,
                          ),
                        ),
                      if (isBookmarked)
                        Container(
                          margin: EdgeInsets.only(right: 1.w),
                          child: CustomIconWidget(
                            iconName: 'star',
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      if (isIncorrect)
                        Container(
                          margin: EdgeInsets.only(right: 1.w),
                          child: CustomIconWidget(
                            iconName: 'error',
                            color: AppTheme.lightTheme.colorScheme.error,
                            size: 16,
                          ),
                        ),
                      // Difficulty badge
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(difficulty)
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          difficulty,
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: _getDifficultyColor(difficulty),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              // Question preview
              Text(
                questionText,
                style: AppTheme.lightTheme.textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
              // Topics and attempts
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 1.w,
                      runSpacing: 0.5.h,
                      children: topics
                          .take(3)
                          .map((topic) => Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 0.5.h),
                                decoration: BoxDecoration(
                                  color: AppTheme
                                      .lightTheme.colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  topic,
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onPrimaryContainer,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  if (attempts > 0) ...[
                    SizedBox(width: 2.w),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'people',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          '${attempts}k',
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'bookmark_border',
                color: AppTheme.lightTheme.primaryColor,
                size: 24,
              ),
              title: Text('Bookmark Question'),
              onTap: () {
                Navigator.pop(context);
                onBookmark();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'play_circle_outline',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 24,
              ),
              title: Text('Practice Mode'),
              onTap: () {
                Navigator.pop(context);
                onPractice();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'quiz',
                color: AppTheme.lightTheme.colorScheme.tertiary,
                size: 24,
              ),
              title: Text('Add to Test'),
              onTap: () {
                Navigator.pop(context);
                onAddToTest();
              },
            ),
            SizedBox(height: 2.h),
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
        return 'book';
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
