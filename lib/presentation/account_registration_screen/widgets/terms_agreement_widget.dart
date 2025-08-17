import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TermsAgreementWidget extends StatefulWidget {
  final Function(bool isAgreed) onAgreementChanged;
  final bool isAgreed;

  const TermsAgreementWidget({
    Key? key,
    required this.onAgreementChanged,
    required this.isAgreed,
  }) : super(key: key);

  @override
  State<TermsAgreementWidget> createState() => _TermsAgreementWidgetState();
}

class _TermsAgreementWidgetState extends State<TermsAgreementWidget> {
  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            'Terms of Service',
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.pureWhiteText,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome to Football Connect! By creating an account, you agree to the following terms:',
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.pureWhiteText,
                  ),
                ),
                SizedBox(height: 2.h),
                _buildTermSection(
                  '1. Account Responsibility',
                  'You are responsible for maintaining the security of your account and all activities that occur under your account.',
                ),
                _buildTermSection(
                  '2. Content Guidelines',
                  'All content shared must be respectful, appropriate, and related to football. Harassment, spam, or inappropriate content is prohibited.',
                ),
                _buildTermSection(
                  '3. Privacy',
                  'We respect your privacy and will protect your personal information according to our Privacy Policy.',
                ),
                _buildTermSection(
                  '4. Community Standards',
                  'Football Connect is a community for football enthusiasts. Please be respectful to other members and follow community guidelines.',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.interactivePurple,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            'Privacy Policy',
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.pureWhiteText,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your privacy is important to us. This policy explains how we collect, use, and protect your information:',
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.pureWhiteText,
                  ),
                ),
                SizedBox(height: 2.h),
                _buildTermSection(
                  'Information We Collect',
                  'We collect information you provide when creating your account, posting content, and interacting with other users.',
                ),
                _buildTermSection(
                  'How We Use Information',
                  'Your information is used to provide and improve our services, personalize your experience, and connect you with other football fans.',
                ),
                _buildTermSection(
                  'Information Sharing',
                  'We do not sell your personal information. We may share information only as necessary to provide our services or as required by law.',
                ),
                _buildTermSection(
                  'Data Security',
                  'We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.interactivePurple,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTermSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
              color: AppTheme.interactivePurple,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            content,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.pureWhiteText.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Terms Agreement Checkbox
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => widget.onAgreementChanged(!widget.isAgreed),
              child: Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(top: 0.2.h),
                decoration: BoxDecoration(
                  color: widget.isAgreed
                      ? AppTheme.interactivePurple
                      : Colors.transparent,
                  border: Border.all(
                    color: widget.isAgreed
                        ? AppTheme.interactivePurple
                        : AppTheme.pureWhiteText.withValues(alpha: 0.5),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: widget.isAgreed
                    ? CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.pureWhiteText,
                        size: 14,
                      )
                    : null,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.pureWhiteText.withValues(alpha: 0.8),
                  ),
                  children: [
                    const TextSpan(text: 'I agree to the '),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: _showTermsDialog,
                        child: Text(
                          'Terms of Service',
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.interactivePurple,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: AppTheme.interactivePurple,
                          ),
                        ),
                      ),
                    ),
                    const TextSpan(text: ' and '),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: _showPrivacyDialog,
                        child: Text(
                          'Privacy Policy',
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.interactivePurple,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: AppTheme.interactivePurple,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
