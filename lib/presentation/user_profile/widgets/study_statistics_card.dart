import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class StudyStatisticsCard extends StatelessWidget {
  final List<double> weeklyActivity;
  final int totalStudyTime;
  final List<String> favoriteSubjects;

  const StudyStatisticsCard({
    Key? key,
    required this.weeklyActivity,
    required this.totalStudyTime,
    required this.favoriteSubjects,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Study Statistics',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 3.h),
          _buildWeeklyActivityChart(),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: 'schedule',
                  title: 'Total Study Time',
                  value: '${totalStudyTime}h',
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: _buildFavoriteSubjects(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyActivityChart() {
    return Container(
      height: 20.h,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: weeklyActivity.reduce((a, b) => a > b ? a : b) + 1,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun'
                  ];
                  return Text(
                    days[value.toInt()],
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: weeklyActivity.asMap().entries.map((entry) {
            return BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  toY: entry.value,
                  color: AppTheme.lightTheme.colorScheme.primary,
                  width: 4.w,
                  borderRadius: BorderRadius.circular(1.w),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: icon,
            color: color,
            size: 6.w,
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteSubjects() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: 'favorite',
            color: AppTheme.lightTheme.colorScheme.secondary,
            size: 6.w,
          ),
          SizedBox(height: 1.h),
          Text(
            'Favorite Subjects',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: AppTheme.lightTheme.colorScheme.secondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          ...favoriteSubjects.take(3).map((subject) => Padding(
                padding: EdgeInsets.only(bottom: 0.5.h),
                child: Text(
                  subject,
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.lightTheme.colorScheme.secondary,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
