import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BulkActionsToolbarWidget extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onSelectAll;
  final VoidCallback onDeselectAll;
  final VoidCallback onDelete;
  final VoidCallback onMove;
  final VoidCallback onShare;
  final VoidCallback onBookmark;
  final VoidCallback onCancel;

  const BulkActionsToolbarWidget({
    Key? key,
    required this.selectedCount,
    required this.onSelectAll,
    required this.onDeselectAll,
    required this.onDelete,
    required this.onMove,
    required this.onShare,
    required this.onBookmark,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.primaryColor,
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: onCancel,
                child: CustomIconWidget(
                  iconName: 'close',
                  color: Colors.white,
                  size: 6.w,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                '$selectedCount selected',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  _buildActionButton(
                    icon: 'select_all',
                    onTap: onSelectAll,
                  ),
                  SizedBox(width: 4.w),
                  _buildActionButton(
                    icon: 'bookmark_border',
                    onTap: onBookmark,
                  ),
                  SizedBox(width: 4.w),
                  _buildActionButton(
                    icon: 'folder',
                    onTap: onMove,
                  ),
                  SizedBox(width: 4.w),
                  _buildActionButton(
                    icon: 'share',
                    onTap: onShare,
                  ),
                  SizedBox(width: 4.w),
                  _buildActionButton(
                    icon: 'delete',
                    onTap: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CustomIconWidget(
          iconName: icon,
          color: Colors.white,
          size: 5.w,
        ),
      ),
    );
  }
}
