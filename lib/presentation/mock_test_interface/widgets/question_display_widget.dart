import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuestionDisplayWidget extends StatelessWidget {
  final Map<String, dynamic> question;
  final String? selectedAnswer;
  final Function(String) onAnswerSelected;

  const QuestionDisplayWidget({
    Key? key,
    required this.question,
    this.selectedAnswer,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questionText = question['question'] as String? ?? '';
    final options = (question['options'] as List?)?.cast<String>() ?? [];
    final questionImage = question['image'] as String?;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Text
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question ${question['id'] ?? 1}',
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.lightTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  questionText,
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // Question Image (if available)
                if (questionImage != null) ...[
                  SizedBox(height: 2.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CustomImageWidget(
                      imageUrl: questionImage,
                      width: double.infinity,
                      height: 25.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ],
            ),
          ),

          SizedBox(height: 3.h),

          // Options
          Text(
            'Choose the correct answer:',
            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),

          SizedBox(height: 2.h),

          // Option Cards
          ...options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final optionLabel = String.fromCharCode(65 + index); // A, B, C, D
            final isSelected = selectedAnswer == optionLabel;

            return Container(
              margin: EdgeInsets.only(bottom: 2.h),
              child: GestureDetector(
                onTap: () => onAnswerSelected(optionLabel),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.lightTheme.primaryColor
                            .withValues(alpha: 0.1)
                        : AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.lightTheme.primaryColor
                          : AppTheme.lightTheme.colorScheme.outline,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Radio Button
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.lightTheme.primaryColor
                                : AppTheme.lightTheme.colorScheme.outline,
                            width: 2,
                          ),
                          color: isSelected
                              ? AppTheme.lightTheme.primaryColor
                              : Colors.transparent,
                        ),
                        child: isSelected
                            ? Center(
                                child: Container(
                                  width: 2.w,
                                  height: 2.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : null,
                      ),

                      SizedBox(width: 3.w),

                      // Option Label
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.lightTheme.primaryColor
                              : AppTheme.lightTheme.colorScheme.outline
                                  .withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            optionLabel,
                            style: AppTheme.lightTheme.textTheme.labelLarge
                                ?.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppTheme.lightTheme.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 3.w),

                      // Option Text
                      Expanded(
                        child: Text(
                          option,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: isSelected
                                ? AppTheme.lightTheme.primaryColor
                                : AppTheme.lightTheme.colorScheme.onSurface,
                            fontWeight:
                                isSelected ? FontWeight.w500 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
