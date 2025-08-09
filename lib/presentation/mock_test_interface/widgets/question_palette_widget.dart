import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuestionPaletteWidget extends StatelessWidget {
  final int totalQuestions;
  final int currentQuestion;
  final List<int> answeredQuestions;
  final List<int> markedQuestions;
  final Function(int) onQuestionTap;
  final VoidCallback onClose;

  const QuestionPaletteWidget({
    Key? key,
    required this.totalQuestions,
    required this.currentQuestion,
    required this.answeredQuestions,
    required this.markedQuestions,
    required this.onQuestionTap,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.w,
      height: 70.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question Palette',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: CustomIconWidget(
                    iconName: 'close',
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // Legend
          Container(
            padding: EdgeInsets.all(3.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegendItem(
                    'Answered', AppTheme.lightTheme.colorScheme.tertiary),
                _buildLegendItem('Marked', AppTheme.warningLight),
                _buildLegendItem('Not Attempted', Colors.grey.shade300),
                _buildLegendItem('Current', AppTheme.lightTheme.primaryColor),
              ],
            ),
          ),

          // Question Grid
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 2.w,
                  mainAxisSpacing: 1.h,
                  childAspectRatio: 1,
                ),
                itemCount: totalQuestions,
                itemBuilder: (context, index) {
                  final questionNumber = index + 1;
                  return _buildQuestionButton(questionNumber);
                },
              ),
            ),
          ),

          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            fontSize: 10.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildQuestionButton(int questionNumber) {
    Color backgroundColor;
    Color textColor = Colors.white;

    if (questionNumber == currentQuestion) {
      backgroundColor = AppTheme.lightTheme.primaryColor;
    } else if (answeredQuestions.contains(questionNumber)) {
      backgroundColor = AppTheme.lightTheme.colorScheme.tertiary;
    } else if (markedQuestions.contains(questionNumber)) {
      backgroundColor = AppTheme.warningLight;
    } else {
      backgroundColor = Colors.grey.shade300;
      textColor = Colors.black87;
    }

    return GestureDetector(
      onTap: () => onQuestionTap(questionNumber),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: questionNumber == currentQuestion
              ? Border.all(color: AppTheme.lightTheme.primaryColor, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            questionNumber.toString(),
            style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
