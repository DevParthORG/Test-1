import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SocialConnectionsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> mutualFriends;
  final List<Map<String, dynamic>> suggestedFollows;
  final Function(Map<String, dynamic>) onFriendTap;
  final Function(Map<String, dynamic>) onFollowSuggestion;

  const SocialConnectionsWidget({
    Key? key,
    required this.mutualFriends,
    required this.suggestedFollows,
    required this.onFriendTap,
    required this.onFollowSuggestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mutual Friends Section
          if (mutualFriends.isNotEmpty) ...[
            Text(
              'Mutual Friends',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.pureWhiteText,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            Container(
              height: 12.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: mutualFriends.length,
                separatorBuilder: (context, index) => SizedBox(width: 3.w),
                itemBuilder: (context, index) {
                  final friend = mutualFriends[index];
                  return _buildFriendItem(friend, onFriendTap);
                },
              ),
            ),
            SizedBox(height: 3.h),
          ],

          // Suggested Follows Section
          if (suggestedFollows.isNotEmpty) ...[
            Text(
              'Suggested for You',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.pureWhiteText,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  suggestedFollows.length > 3 ? 3 : suggestedFollows.length,
              separatorBuilder: (context, index) => SizedBox(height: 1.h),
              itemBuilder: (context, index) {
                final suggestion = suggestedFollows[index];
                return _buildSuggestionItem(suggestion);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFriendItem(
      Map<String, dynamic> friend, Function(Map<String, dynamic>) onTap) {
    return GestureDetector(
      onTap: () => onTap(friend),
      child: Column(
        children: [
          Container(
            width: 15.w,
            height: 15.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.interactivePurple.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: CustomImageWidget(
                imageUrl: friend['avatar'] as String? ?? '',
                width: 15.w,
                height: 15.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Container(
            width: 18.w,
            child: Text(
              friend['name'] as String? ?? '',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.pureWhiteText,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionItem(Map<String, dynamic> suggestion) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceGray,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.dividerColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.interactivePurple.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: CustomImageWidget(
                imageUrl: suggestion['avatar'] as String? ?? '',
                width: 12.w,
                height: 12.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  suggestion['name'] as String? ?? '',
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    color: AppTheme.pureWhiteText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  '${suggestion['mutualFriends'] ?? 0} mutual friends',
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.neutralGray,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20.w,
            height: 5.h,
            child: ElevatedButton(
              onPressed: () => onFollowSuggestion(suggestion),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.interactivePurple,
                foregroundColor: AppTheme.pureWhiteText,
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Follow',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.pureWhiteText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
