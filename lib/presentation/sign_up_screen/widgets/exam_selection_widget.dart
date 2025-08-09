import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class ExamSelectionWidget extends StatefulWidget {
  final String? selectedExam;
  final Function(String) onExamSelected;

  const ExamSelectionWidget({
    Key? key,
    this.selectedExam,
    required this.onExamSelected,
  }) : super(key: key);

  @override
  State<ExamSelectionWidget> createState() => _ExamSelectionWidgetState();
}

class _ExamSelectionWidgetState extends State<ExamSelectionWidget> {
  final List<Map<String, dynamic>> examOptions = [
    {
      "id": "jee",
      "name": "JEE (Joint Entrance Examination)",
      "description":
          "Engineering entrance exam for IITs, NITs, and other technical institutes",
      "icon": "engineering",
    },
    {
      "id": "neet",
      "name": "NEET (National Eligibility cum Entrance Test)",
      "description":
          "Medical entrance exam for MBBS, BDS, and other medical courses",
      "icon": "local_hospital",
    },
    {
      "id": "upsc",
      "name": "UPSC (Union Public Service Commission)",
      "description":
          "Civil services examination for IAS, IPS, and other government positions",
      "icon": "account_balance",
    },
    {
      "id": "cat",
      "name": "CAT (Common Admission Test)",
      "description":
          "Management entrance exam for IIMs and other business schools",
      "icon": "business_center",
    },
    {
      "id": "gate",
      "name": "GATE (Graduate Aptitude Test in Engineering)",
      "description": "Engineering postgraduate entrance exam",
      "icon": "school",
    },
    {
      "id": "ssc",
      "name": "SSC (Staff Selection Commission)",
      "description": "Government job recruitment examination",
      "icon": "work",
    },
  ];

  void _showExamSelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: Text(
                'Select Your Target Exam',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                itemCount: examOptions.length,
                separatorBuilder: (context, index) => SizedBox(height: 1.h),
                itemBuilder: (context, index) {
                  final exam = examOptions[index];
                  final isSelected = widget.selectedExam == exam["id"];

                  return GestureDetector(
                    onTap: () {
                      widget.onExamSelected(exam["id"]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).dividerColor,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12.w,
                            height: 12.w,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomIconWidget(
                              iconName: exam["icon"],
                              color: isSelected
                                  ? Colors.white
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                              size: 6.w,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exam["name"],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : null,
                                      ),
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  exam["description"],
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            CustomIconWidget(
                              iconName: 'check_circle',
                              color: Theme.of(context).colorScheme.primary,
                              size: 6.w,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedExamData = widget.selectedExam != null
        ? examOptions.firstWhere(
            (exam) => exam["id"] == widget.selectedExam,
            orElse: () => {"name": "Select Your Exam"},
          )
        : {"name": "Select Your Exam"};

    return GestureDetector(
      onTap: _showExamSelectionBottomSheet,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedExamData["name"],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: widget.selectedExam != null
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withValues(alpha: 0.7),
                    ),
              ),
            ),
            CustomIconWidget(
              iconName: 'keyboard_arrow_down',
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
          ],
        ),
      ),
    );
  }
}
