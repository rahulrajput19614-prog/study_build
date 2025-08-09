import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:sizer/sizer.dart';

class TermsCheckboxWidget extends StatelessWidget {
  final bool isAccepted;
  final Function(bool?) onChanged;
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  const TermsCheckboxWidget({
    Key? key,
    required this.isAccepted,
    required this.onChanged,
    required this.onTermsTap,
    required this.onPrivacyTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 6.w,
          height: 6.w,
          child: Checkbox(
            value: isAccepted,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    height: 1.4,
                  ),
              children: [
                TextSpan(
                  text: 'I agree to the ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onTermsTap,
                ),
                TextSpan(
                  text: ' and ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onPrivacyTap,
                ),
                TextSpan(
                  text:
                      '. I consent to receive educational content and updates via email.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
