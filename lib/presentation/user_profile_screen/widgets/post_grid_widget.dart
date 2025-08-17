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
          crossAxisSpacing: 2.w,
          mainAxisSpacing: 2.w,
          childAspectRatio: 1.0,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return _buildPostThumbnail(post);
        },
      ),
    );
  }

  Widget _buildPostThumbnail(Map<String, dynamic> post) {
    return GestureDetector(
      onTap: () => onPostTap(post),
      onLongPress: () => onPostLongPress(post),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.dividerColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomImageWidget(
                imageUrl: post['imageUrl'] as String? ?? '',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Overlay with post type indicator
            if (post['type'] == 'video')
              Positioned(
                top: 1.w,
                right: 1.w,
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBackground.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomIconWidget(
                    iconName: 'play_arrow',
                    color: AppTheme.pureWhiteText,
                    size: 4.w,
                  ),
                ),
              ),

            // Likes count overlay
            Positioned(
              bottom: 1.w,
              left: 1.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBackground.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: 'favorite',
                      color: AppTheme.errorRed,
                      size: 3.w,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      post['likesCount']?.toString() ?? '0',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.pureWhiteText,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 40.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: AppTheme.surfaceGray,
              shape: BoxShape.circle,
            ),
            child: CustomIconWidget(
              iconName: 'photo_library',
              color: AppTheme.neutralGray,
              size: 10.w,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'No Posts Yet',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.pureWhiteText,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Share your first football moment\nwith the community!',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.neutralGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
