import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CoverPhotoWidget extends StatelessWidget {
  final String coverImageUrl;
  final VoidCallback onEditPressed;

  const CoverPhotoWidget({
    Key? key,
    required this.coverImageUrl,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 25.h,
      child: Stack(
        children: [
          // Cover Photo
          Container(
            width: double.infinity,
            height: 25.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: CustomImageWidget(
                imageUrl: coverImageUrl,
                width: double.infinity,
                height: 25.h,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay
          Container(
            width: double.infinity,
            height: 25.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppTheme.primaryBackground.withValues(alpha: 0.3),
                  AppTheme.primaryBackground.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),

          // Edit Button
          Positioned(
            bottom: 2.h,
            right: 4.w,
            child: GestureDetector(
              onTap: onEditPressed,
              child: Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: AppTheme.primaryBackground.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.pureWhiteText.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: CustomIconWidget(
                  iconName: 'edit',
                  color: AppTheme.pureWhiteText,
                  size: 5.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
