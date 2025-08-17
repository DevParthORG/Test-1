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
            _buildSectionHeader(
                'Mutual Friends', 'people', AppTheme.successGreen),
            SizedBox(height: 2.h),
            Container(
              height: 14.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: mutualFriends.length,
                separatorBuilder: (context, index) => SizedBox(width: 3.w),
                itemBuilder: (context, index) {
                  final friend = mutualFriends[index];
                  return _buildFriendItem(friend, onFriendTap, index);
                },
              ),
            ),
            SizedBox(height: 4.h),
          ],

          // Suggested Follows Section
          if (suggestedFollows.isNotEmpty) ...[
            _buildSectionHeader(
                'Suggested for You', 'group_add', AppTheme.interactivePurple),
            SizedBox(height: 2.h),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  suggestedFollows.length > 3 ? 3 : suggestedFollows.length,
              separatorBuilder: (context, index) => SizedBox(height: 2.h),
              itemBuilder: (context, index) {
                final suggestion = suggestedFollows[index];
                return _buildSuggestionItem(suggestion, index);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String iconName, Color accentColor) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withValues(alpha: 0.15),
            accentColor.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowColor.withValues(alpha: 0.1),
            offset: Offset(0, 4),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2.5.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accentColor, accentColor.withValues(alpha: 0.8)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.3),
                  offset: Offset(0, 4),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: CustomIconWidget(
              iconName: iconName,
              color: AppTheme.pureWhiteText,
              size: 5.w,
            ),
          ),
          SizedBox(width: 3.w),
          Text(
            title,
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.pureWhiteText,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendItem(Map<String, dynamic> friend,
      Function(Map<String, dynamic>) onTap, int index) {
    List<Color> gradientColors = _getFriendGradientColors(index);

    return GestureDetector(
      onTap: () => onTap(friend),
      child: Container(
        width: 20.w,
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              gradientColors[0].withValues(alpha: 0.1),
              gradientColors[1].withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: gradientColors[0].withValues(alpha: 0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowColor.withValues(alpha: 0.1),
              offset: Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            // Enhanced Avatar
            Container(
              width: 16.w,
              height: 16.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: gradientColors,
                ),
                boxShadow: [
                  BoxShadow(
                    color: gradientColors[0].withValues(alpha: 0.3),
                    offset: Offset(0, 4),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ],
              ),
              padding: EdgeInsets.all(0.5.w),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.pureWhiteText.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: CustomImageWidget(
                    imageUrl: friend['avatar'] as String? ?? '',
                    width: 16.w,
                    height: 16.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.5.h),

            // Enhanced Name
            Container(
              width: 18.w,
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: AppTheme.primaryBackground.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                friend['name'] as String? ?? '',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.pureWhiteText,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionItem(Map<String, dynamic> suggestion, int index) {
    List<Color> gradientColors = _getSuggestionGradientColors(index);

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.surfaceGray.withValues(alpha: 0.8),
            AppTheme.surfaceGray.withValues(alpha: 0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: gradientColors[0].withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowColor.withValues(alpha: 0.1),
            offset: Offset(0, 6),
            blurRadius: 20,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: gradientColors[0].withValues(alpha: 0.05),
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Enhanced Avatar
          Container(
            width: 14.w,
            height: 14.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: gradientColors,
              ),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[0].withValues(alpha: 0.3),
                  offset: Offset(0, 4),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            padding: EdgeInsets.all(0.5.w),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.pureWhiteText.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: CustomImageWidget(
                  imageUrl: suggestion['avatar'] as String? ?? '',
                  width: 14.w,
                  height: 14.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),

          // User Info Section
          Expanded(
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryBackground.withValues(alpha: 0.2),
                    AppTheme.primaryBackground.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suggestion['name'] as String? ?? '',
                    style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                      color: AppTheme.pureWhiteText,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: AppTheme.neutralGray.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${suggestion['mutualFriends'] ?? 0} mutual friends',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.neutralGray,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 3.w),

          // Enhanced Follow Button
          Container(
            width: 22.w,
            height: 6.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[0].withValues(alpha: 0.3),
                  offset: Offset(0, 4),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => onFollowSuggestion(suggestion),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppTheme.pureWhiteText,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'person_add',
                    color: AppTheme.pureWhiteText,
                    size: 4.w,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    'Follow',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.pureWhiteText,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getFriendGradientColors(int index) {
    List<List<Color>> gradients = [
      [AppTheme.successGreen, AppTheme.interactivePurple],
      [AppTheme.footballOrange, AppTheme.successGreen],
      [AppTheme.interactivePurple, AppTheme.footballOrange],
      [AppTheme.successGreen, AppTheme.footballOrange],
    ];
    return gradients[index % gradients.length];
  }

  List<Color> _getSuggestionGradientColors(int index) {
    List<List<Color>> gradients = [
      [AppTheme.interactivePurple, AppTheme.footballOrange],
      [AppTheme.footballOrange, AppTheme.successGreen],
      [AppTheme.successGreen, AppTheme.interactivePurple],
    ];
    return gradients[index % gradients.length];
  }
}
