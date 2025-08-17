import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PostGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> posts;
  final Function(Map<String, dynamic>) onPostTap;
  final Function(Map<String, dynamic>) onPostLongPress;

  const PostGridWidget({
    Key? key,
    required this.posts,
    required this.onPostTap,
    required this.onPostLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 3.w,
          childAspectRatio: 1.0,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return _buildPostThumbnail(post, index);
        },
      ),
    );
  }

  Widget _buildPostThumbnail(Map<String, dynamic> post, int index) {
    // Create different gradient combinations for visual variety
    List<Color> gradientColors = _getGradientColors(index);

    return GestureDetector(
      onTap: () => onPostTap(post),
      onLongPress: () => onPostLongPress(post),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              gradientColors[0].withValues(alpha: 0.1),
              gradientColors[1].withValues(alpha: 0.05),
            ],
          ),
          border: Border.all(
            color: gradientColors[0].withValues(alpha: 0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowColor.withValues(alpha: 0.1),
              offset: Offset(0, 4),
              blurRadius: 16,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: gradientColors[0].withValues(alpha: 0.1),
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Image with Overlay
              Stack(
                children: [
                  CustomImageWidget(
                    imageUrl: post['imageUrl'] as String? ?? '',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Subtle gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.7, 1.0],
                        colors: [
                          Colors.transparent,
                          AppTheme.primaryBackground.withValues(alpha: 0.1),
                          AppTheme.primaryBackground.withValues(alpha: 0.4),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Enhanced Post Type Indicator
              if (post['type'] == 'video')
                Positioned(
                  top: 2.w,
                  right: 2.w,
                  child: Container(
                    padding: EdgeInsets.all(1.5.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.footballOrange,
                          AppTheme.errorRed,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.pureWhiteText.withValues(alpha: 0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.shadowColor.withValues(alpha: 0.2),
                          offset: Offset(0, 2),
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: CustomIconWidget(
                      iconName: 'play_arrow',
                      color: AppTheme.pureWhiteText,
                      size: 4.w,
                    ),
                  ),
                ),

              // Enhanced Likes Count
              Positioned(
                bottom: 2.w,
                left: 2.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.primaryBackground.withValues(alpha: 0.8),
                        AppTheme.surfaceGray.withValues(alpha: 0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.pureWhiteText.withValues(alpha: 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.shadowColor.withValues(alpha: 0.15),
                        offset: Offset(0, 2),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(1.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.errorRed,
                              AppTheme.footballOrange,
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CustomIconWidget(
                          iconName: 'favorite',
                          color: AppTheme.pureWhiteText,
                          size: 2.5.w,
                        ),
                      ),
                      SizedBox(width: 1.5.w),
                      Text(
                        _formatCount(post['likesCount'] ?? 0),
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.pureWhiteText,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Corner Accent
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.surfaceGray.withValues(alpha: 0.4),
            AppTheme.surfaceGray.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppTheme.dividerColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowColor.withValues(alpha: 0.1),
            offset: Offset(0, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Enhanced Icon Container
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.interactivePurple.withValues(alpha: 0.2),
                  AppTheme.footballOrange.withValues(alpha: 0.1),
                ],
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.neutralGray.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.neutralGray.withValues(alpha: 0.3),
                    AppTheme.neutralGray.withValues(alpha: 0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'photo_library',
                color: AppTheme.neutralGray,
                size: 12.w,
              ),
            ),
          ),
          SizedBox(height: 3.h),

          // Enhanced Title
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.interactivePurple.withValues(alpha: 0.1),
                  AppTheme.footballOrange.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'No Posts Yet',
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.pureWhiteText,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(height: 2.h),

          // Enhanced Description
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryBackground.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.neutralGray.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Text(
              'Share your first football moment\nwith the community!',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.neutralGray,
                height: 1.5,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getGradientColors(int index) {
    List<List<Color>> gradients = [
      [AppTheme.interactivePurple, AppTheme.footballOrange],
      [AppTheme.footballOrange, AppTheme.successGreen],
      [AppTheme.successGreen, AppTheme.interactivePurple],
      [AppTheme.interactivePurple, AppTheme.successGreen],
      [AppTheme.footballOrange, AppTheme.interactivePurple],
      [AppTheme.successGreen, AppTheme.footballOrange],
    ];
    return gradients[index % gradients.length];
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }
}
