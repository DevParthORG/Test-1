import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FootballLogoWidget extends StatelessWidget {
  const FootballLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Football Connect Logo
        Container(
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            color: AppTheme.interactivePurple,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.interactivePurple.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: CustomIconWidget(
            iconName: 'sports_soccer',
            color: AppTheme.pureWhiteText,
            size: 10.w,
          ),
        ),
        SizedBox(height: 3.h),

        // App Name
        Text(
          'Football Connect',
          style: AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
            color: AppTheme.pureWhiteText,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 1.h),

        // Subtitle
        Text(
          'Join the ultimate football community',
          style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
            color: AppTheme.pureWhiteText.withValues(alpha: 0.7),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
