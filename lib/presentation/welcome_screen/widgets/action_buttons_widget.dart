import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ActionButtonsWidget extends StatelessWidget {
  final bool isTermsAccepted;
  final VoidCallback onCreateAccount;
  final VoidCallback onAlreadyHaveAccount;

  const ActionButtonsWidget({
    Key? key,
    required this.isTermsAccepted,
    required this.onCreateAccount,
    required this.onAlreadyHaveAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 7.h,
          child: ElevatedButton(
            onPressed: isTermsAccepted ? onCreateAccount : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isTermsAccepted
                  ? AppTheme.interactivePurple
                  : AppTheme.neutralGray.withValues(alpha: 0.3),
              foregroundColor: AppTheme.pureWhiteText,
              elevation: isTermsAccepted ? 4 : 0,
              shadowColor: isTermsAccepted
                  ? AppTheme.interactivePurple.withValues(alpha: 0.3)
                  : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Create a new account',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.pureWhiteText,
              ),
            ),
          ),
        ),
        SizedBox(height: 3.h),
        GestureDetector(
          onTap: onAlreadyHaveAccount,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
            child: Text(
              'I already have an account',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppTheme.pureWhiteText.withValues(alpha: 0.8),
                decoration: TextDecoration.underline,
                decorationColor: AppTheme.pureWhiteText.withValues(alpha: 0.8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}