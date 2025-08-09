import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NoteCardWidget extends StatelessWidget {
  final Map<String, dynamic> note;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onShare;
  final VoidCallback? onMove;
  final VoidCallback? onDelete;
  final bool isSelected;
  final bool isMultiSelectMode;
  final ValueChanged<bool>? onSelectionChanged;

  const NoteCardWidget({
    Key? key,
    required this.note,
    this.onTap,
    this.onEdit,
    this.onShare,
    this.onMove,
    this.onDelete,
    this.isSelected = false,
    this.isMultiSelectMode = false,
    this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(note['id'].toString()),
      background: _buildSwipeBackground(context, isLeft: false),
      secondaryBackground: _buildSwipeBackground(context, isLeft: true),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete?.call();
        } else if (direction == DismissDirection.startToEnd) {
          onEdit?.call();
        }
      },
      child: GestureDetector(
        onTap: isMultiSelectMode
            ? () => onSelectionChanged?.call(!isSelected)
            : onTap,
        onLongPress: () => onSelectionChanged?.call(!isSelected),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1)
                : AppTheme.lightTheme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: AppTheme.lightTheme.primaryColor, width: 2)
                : Border.all(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.colorScheme.shadow
                    .withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isMultiSelectMode) ...[
                  Container(
                    width: 6.w,
                    height: 6.w,
                    margin: EdgeInsets.only(right: 3.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppTheme.lightTheme.primaryColor
                          : Colors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.lightTheme.primaryColor
                            : AppTheme.lightTheme.colorScheme.outline,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? CustomIconWidget(
                            iconName: 'check',
                            color: Colors.white,
                            size: 3.w,
                          )
                        : null,
                  ),
                ],
                _buildThumbnail(),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              note['title'] as String? ?? 'Untitled Note',
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (note['isBookmarked'] == true)
                            CustomIconWidget(
                              iconName: 'bookmark',
                              color: AppTheme.lightTheme.colorScheme.secondary,
                              size: 4.w,
                            ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        note['preview'] as String? ?? 'No preview available',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1.5.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                              color: _getSubjectColor(
                                      note['subject'] as String? ?? '')
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              note['subject'] as String? ?? 'General',
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: _getSubjectColor(
                                    note['subject'] as String? ?? ''),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              if (note['syncStatus'] == 'synced')
                                CustomIconWidget(
                                  iconName: 'cloud_done',
                                  color:
                                      AppTheme.lightTheme.colorScheme.tertiary,
                                  size: 3.w,
                                )
                              else if (note['syncStatus'] == 'syncing')
                                SizedBox(
                                  width: 3.w,
                                  height: 3.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppTheme.lightTheme.primaryColor,
                                    ),
                                  ),
                                )
                              else
                                CustomIconWidget(
                                  iconName: 'cloud_off',
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                  size: 3.w,
                                ),
                              SizedBox(width: 2.w),
                              Text(
                                note['createdAt'] as String? ?? 'Unknown',
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    final contentType = note['contentType'] as String? ?? 'text';
    final thumbnailUrl = note['thumbnailUrl'] as String?;

    return Container(
      width: 12.w,
      height: 12.w,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: thumbnailUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomImageWidget(
                imageUrl: thumbnailUrl,
                width: 12.w,
                height: 12.w,
                fit: BoxFit.cover,
              ),
            )
          : CustomIconWidget(
              iconName: _getContentTypeIcon(contentType),
              color: AppTheme.lightTheme.primaryColor,
              size: 6.w,
            ),
    );
  }

  Widget _buildSwipeBackground(BuildContext context, {required bool isLeft}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isLeft
            ? AppTheme.lightTheme.colorScheme.error
            : AppTheme.lightTheme.colorScheme.tertiary,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: isLeft ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: isLeft ? 'delete' : 'edit',
            color: Colors.white,
            size: 6.w,
          ),
          SizedBox(height: 0.5.h),
          Text(
            isLeft ? 'Delete' : 'Edit',
            style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getContentTypeIcon(String contentType) {
    switch (contentType.toLowerCase()) {
      case 'image':
        return 'image';
      case 'formula':
        return 'functions';
      case 'voice':
        return 'mic';
      case 'scan':
        return 'document_scanner';
      default:
        return 'description';
    }
  }

  Color _getSubjectColor(String subject) {
    switch (subject.toLowerCase()) {
      case 'mathematics':
      case 'math':
        return const Color(0xFF2563EB);
      case 'physics':
        return const Color(0xFF7C3AED);
      case 'chemistry':
        return const Color(0xFF059669);
      case 'biology':
        return const Color(0xFFD97706);
      case 'english':
        return const Color(0xFFDC2626);
      case 'history':
        return const Color(0xFF0891B2);
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }
}
