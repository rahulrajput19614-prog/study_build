import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class SocialSignupWidget extends StatelessWidget {
  final VoidCallback onGoogleSignup;
  final VoidCallback onAppleSignup;

  const SocialSignupWidget({
    Key? key,
    required this.onGoogleSignup,
    required this.onAppleSignup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: Theme.of(context).dividerColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                'Or continue with',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        Row(
          children: [
            Expanded(
              child: _buildSocialButton(
                context: context,
                label: 'Google',
                iconName: 'g_translate',
                onTap: onGoogleSignup,
                backgroundColor: Colors.white,
                textColor: Colors.black87,
                borderColor: Colors.grey.shade300,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: _buildSocialButton(
                context: context,
                label: 'Apple',
                iconName: 'apple',
                onTap: onAppleSignup,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                borderColor: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required BuildContext context,
    required String label,
    required String iconName,
    required VoidCallback onTap,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 6.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: textColor,
              size: 5.w,
            ),
            SizedBox(width: 2.w),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
