import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CreationOptionsWidget extends StatelessWidget {
  final VoidCallback onTextNote;
  final VoidCallback onVoiceNote;
  final VoidCallback onCameraScan;
  final VoidCallback onAIGenerate;
  final VoidCallback onClose;

  const CreationOptionsWidget({
    Key? key,
    required this.onTextNote,
    required this.onVoiceNote,
    required this.onCameraScan,
    required this.onAIGenerate,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(6.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'Create New Note',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onClose,
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
                        shape: BoxShape.circle,
                      ),
                      child: CustomIconWidget(
                        iconName: 'close',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 5.w,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Expanded(
                    child: _buildOptionCard(
                      icon: 'edit_note',
                      title: 'Text Note',
                      subtitle: 'Write your thoughts',
                      color: AppTheme.lightTheme.primaryColor,
                      onTap: onTextNote,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: _buildOptionCard(
                      icon: 'mic',
                      title: 'Voice Note',
                      subtitle: 'Record audio',
                      color: AppTheme.lightTheme.colorScheme.secondary,
                      onTap: onVoiceNote,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Row(
                children: [
                  Expanded(
                    child: _buildOptionCard(
                      icon: 'camera_alt',
                      title: 'Camera Scan',
                      subtitle: 'Scan documents',
                      color: AppTheme.lightTheme.colorScheme.tertiary,
                      onTap: onCameraScan,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: _buildOptionCard(
                      icon: 'auto_awesome',
                      title: 'AI Generate',
                      subtitle: 'Create with AI',
                      color: const Color(0xFFD97706),
                      onTap: onAIGenerate,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomIconWidget(
                iconName: icon,
                color: Colors.white,
                size: 6.w,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 0.5.h),
            Text(
              subtitle,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
