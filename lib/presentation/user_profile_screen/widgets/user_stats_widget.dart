import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class UserStatsWidget extends StatelessWidget {
  final int postsCount;
  final int commentsCount;
  final int likesCount;

  const UserStatsWidget({
    Key? key,
    required this.postsCount,
    required this.commentsCount,
    required this.likesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceGray,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.dividerColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(
            'Posts',
            postsCount.toString(),
            AppTheme.footballOrange,
            'article',
          ),
          _buildDivider(),
          _buildStatItem(
            'Comments',
            commentsCount.toString(),
            AppTheme.successGreen,
            'comment',
          ),
          _buildDivider(),
          _buildStatItem(
            'Likes',
            likesCount.toString(),
            AppTheme.interactivePurple,
            'favorite',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
      String label, String count, Color color, String iconName) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: CustomIconWidget(
              iconName: iconName,
              color: color,
              size: 6.w,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            count,
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.pureWhiteText,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            label,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.neutralGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 8.h,
      color: AppTheme.dividerColor.withValues(alpha: 0.5),
    );
  }
}
