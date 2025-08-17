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
      height: 30.h,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      child: Stack(
        children: [
          // Enhanced Cover Photo Container
          Container(
            width: double.infinity,
            height: 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.interactivePurple.withValues(alpha: 0.1),
                  AppTheme.footballOrange.withValues(alpha: 0.1),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.shadowColor.withValues(alpha: 0.15),
                  offset: Offset(0, 8),
                  blurRadius: 32,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: AppTheme.interactivePurple.withValues(alpha: 0.1),
                  offset: Offset(0, 4),
                  blurRadius: 16,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  // Cover Image
                  CustomImageWidget(
                    imageUrl: coverImageUrl,
                    width: double.infinity,
                    height: 30.h,
                    fit: BoxFit.cover,
                  ),

                  // Enhanced Gradient Overlays
                  Container(
                    width: double.infinity,
                    height: 30.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.3, 0.7, 1.0],
                        colors: [
                          Colors.transparent,
                          AppTheme.primaryBackground.withValues(alpha: 0.1),
                          AppTheme.primaryBackground.withValues(alpha: 0.3),
                          AppTheme.primaryBackground.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),

                  // Decorative Elements
                  Positioned(
                    top: 3.h,
                    right: 4.w,
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.interactivePurple.withValues(alpha: 0.2),
                            AppTheme.footballOrange.withValues(alpha: 0.2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.pureWhiteText.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: CustomIconWidget(
                        iconName: 'sports_soccer',
                        color: AppTheme.pureWhiteText.withValues(alpha: 0.7),
                        size: 6.w,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 4.h,
                    left: 4.w,
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.footballOrange.withValues(alpha: 0.2),
                            AppTheme.successGreen.withValues(alpha: 0.2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.pureWhiteText.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: CustomIconWidget(
                        iconName: 'star',
                        color: AppTheme.pureWhiteText.withValues(alpha: 0.7),
                        size: 5.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Enhanced Edit Button
          Positioned(
            bottom: 3.h,
            right: 4.w,
            child: GestureDetector(
              onTap: onEditPressed,
              child: Container(
                width: 14.w,
                height: 14.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.interactivePurple,
                      AppTheme.footballOrange,
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.pureWhiteText,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.interactivePurple.withValues(alpha: 0.4),
                      offset: Offset(0, 6),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: AppTheme.shadowColor.withValues(alpha: 0.2),
                      offset: Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: CustomIconWidget(
                  iconName: 'edit',
                  color: AppTheme.pureWhiteText,
                  size: 6.w,
                ),
              ),
            ),
          ),

          // Corner Decorations
          Positioned(
            top: 2.h,
            left: 2.w,
            child: Container(
              width: 4.w,
              height: 4.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.interactivePurple.withValues(alpha: 0.6),
                    AppTheme.footballOrange.withValues(alpha: 0.6),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            top: 6.h,
            left: 8.w,
            child: Container(
              width: 2.w,
              height: 2.w,
              decoration: BoxDecoration(
                color: AppTheme.successGreen.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: 8.h,
            right: 12.w,
            child: Container(
              width: 3.w,
              height: 3.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.footballOrange.withValues(alpha: 0.4),
                    AppTheme.successGreen.withValues(alpha: 0.4),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
