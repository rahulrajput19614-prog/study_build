import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SettingsSection extends StatelessWidget {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final String selectedExam;
  final Function(bool) onDarkModeToggle;
  final Function(bool) onNotificationToggle;
  final VoidCallback onExamSelection;
  final VoidCallback onAccountSettings;

  const SettingsSection({
    Key? key,
    required this.isDarkMode,
    required this.notificationsEnabled,
    required this.selectedExam,
    required this.onDarkModeToggle,
    required this.onNotificationToggle,
    required this.onExamSelection,
    required this.onAccountSettings,
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
            'Settings',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 3.h),
          _buildSettingItem(
            icon: 'account_circle',
            title: 'Account Preferences',
            subtitle: 'Manage your account settings',
            onTap: onAccountSettings,
          ),
          _buildDivider(),
          _buildSwitchItem(
            icon: 'notifications',
            title: 'Notifications',
            subtitle: 'Study reminders and updates',
            value: notificationsEnabled,
            onChanged: onNotificationToggle,
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: 'school',
            title: 'Exam Selection',
            subtitle: selectedExam,
            onTap: onExamSelection,
          ),
          _buildDivider(),
          _buildSwitchItem(
            icon: 'dark_mode',
            title: 'Dark Mode',
            subtitle: 'Switch to dark theme',
            value: isDarkMode,
            onChanged: onDarkModeToggle,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(2.w),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Row(
          children: [
            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: icon,
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 5.w,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
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
              iconName: 'chevron_right',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 5.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required String icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: icon,
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 5.w,
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.lightTheme.colorScheme.onSurface,
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
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
      height: 1,
    );
  }
}
