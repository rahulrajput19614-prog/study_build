import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class FilterBottomSheet extends StatefulWidget {
  final Map<String, dynamic> currentFilters;
  final Function(Map<String, dynamic>) onApplyFilters;

  const FilterBottomSheet({
    Key? key,
    required this.currentFilters,
    required this.onApplyFilters,
  }) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late Map<String, dynamic> _filters;

  final List<String> _difficulties = ['Easy', 'Medium', 'Hard'];
  final List<String> _questionTypes = [
    'MCQ',
    'Numerical',
    'Assertion-Reason',
    'Match the Following'
  ];
  final List<String> _solvedStatus = ['All', 'Solved', 'Unsolved', 'Incorrect'];
  final List<String> _topics = [
    'Mechanics',
    'Thermodynamics',
    'Optics',
    'Electricity',
    'Magnetism',
    'Organic Chemistry',
    'Inorganic Chemistry',
    'Physical Chemistry',
    'Algebra',
    'Calculus',
    'Geometry',
    'Trigonometry',
    'Cell Biology',
    'Genetics',
    'Ecology',
    'Human Physiology'
  ];

  @override
  void initState() {
    super.initState();
    _filters = Map<String, dynamic>.from(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 2.h),
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Text(
                  'Advanced Filters',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: _clearFilters,
                  child: Text(
                    'Clear All',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.2)),
          // Filter content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDifficultyFilter(),
                  SizedBox(height: 3.h),
                  _buildQuestionTypeFilter(),
                  SizedBox(height: 3.h),
                  _buildSolvedStatusFilter(),
                  SizedBox(height: 3.h),
                  _buildTopicFilter(),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
          // Apply button
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onApplyFilters(_filters);
                  Navigator.pop(context);
                },
                child: Text('Apply Filters'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Difficulty Level',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: _difficulties.map((difficulty) {
            final isSelected =
                (_filters['difficulties'] as List?)?.contains(difficulty) ??
                    false;
            return FilterChip(
              label: Text(difficulty),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _filters['difficulties'] ??= <String>[];
                  if (selected) {
                    (_filters['difficulties'] as List).add(difficulty);
                  } else {
                    (_filters['difficulties'] as List).remove(difficulty);
                  }
                });
              },
              selectedColor:
                  AppTheme.lightTheme.primaryColor.withValues(alpha: 0.2),
              checkmarkColor: AppTheme.lightTheme.primaryColor,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuestionTypeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question Type',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: _questionTypes.map((type) {
            final isSelected =
                (_filters['questionTypes'] as List?)?.contains(type) ?? false;
            return FilterChip(
              label: Text(type),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _filters['questionTypes'] ??= <String>[];
                  if (selected) {
                    (_filters['questionTypes'] as List).add(type);
                  } else {
                    (_filters['questionTypes'] as List).remove(type);
                  }
                });
              },
              selectedColor: AppTheme.lightTheme.colorScheme.secondary
                  .withValues(alpha: 0.2),
              checkmarkColor: AppTheme.lightTheme.colorScheme.secondary,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSolvedStatusFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Solved Status',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: _solvedStatus.map((status) {
            final isSelected = _filters['solvedStatus'] == status;
            return ChoiceChip(
              label: Text(status),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _filters['solvedStatus'] = selected ? status : null;
                });
              },
              selectedColor: AppTheme.lightTheme.colorScheme.tertiary
                  .withValues(alpha: 0.2),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTopicFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Topics',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          constraints: BoxConstraints(maxHeight: 25.h),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              children: _topics.map((topic) {
                final isSelected =
                    (_filters['topics'] as List?)?.contains(topic) ?? false;
                return FilterChip(
                  label: Text(topic),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _filters['topics'] ??= <String>[];
                      if (selected) {
                        (_filters['topics'] as List).add(topic);
                      } else {
                        (_filters['topics'] as List).remove(topic);
                      }
                    });
                  },
                  selectedColor:
                      AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                  checkmarkColor: AppTheme.lightTheme.primaryColor,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  void _clearFilters() {
    setState(() {
      _filters.clear();
    });
  }
}
