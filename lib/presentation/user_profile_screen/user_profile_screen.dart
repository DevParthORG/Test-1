import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/cover_photo_widget.dart';
import './widgets/post_grid_widget.dart';
import './widgets/profile_header_widget.dart';
import './widgets/social_connections_widget.dart';
import './widgets/user_stats_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int _currentTabIndex = 4; // Profile tab active

  // Mock user data
  final Map<String, dynamic> userData = {
    "id": 1,
    "username": "alex_striker",
    "bio":
        "⚽ Professional footballer | Manchester United FC | Living the dream on and off the pitch 🏆",
    "avatar":
        "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=400",
    "coverPhoto":
        "https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?auto=compress&cs=tinysrgb&w=800",
    "followersCount": 15420,
    "followingCount": 892,
    "postsCount": 156,
    "commentsCount": 2340,
    "likesCount": 45670,
  };

  final List<Map<String, dynamic>> userPosts = [
    {
      "id": 1,
      "imageUrl":
          "https://images.pexels.com/photos/114296/pexels-photo-114296.jpeg?auto=compress&cs=tinysrgb&w=400",
      "type": "image",
      "likesCount": 234,
      "caption": "Training hard for the upcoming match! 💪⚽",
    },
    {
      "id": 2,
      "imageUrl":
          "https://images.pexels.com/photos/1171084/pexels-photo-1171084.jpeg?auto=compress&cs=tinysrgb&w=400",
      "type": "video",
      "likesCount": 567,
      "caption": "Amazing goal from yesterday's practice session!",
    },
    {
      "id": 3,
      "imageUrl":
          "https://images.pexels.com/photos/209977/pexels-photo-209977.jpeg?auto=compress&cs=tinysrgb&w=400",
      "type": "image",
      "likesCount": 189,
      "caption": "Team celebration after our victory! 🎉",
    },
    {
      "id": 4,
      "imageUrl":
          "https://images.pexels.com/photos/1884574/pexels-photo-1884574.jpeg?auto=compress&cs=tinysrgb&w=400",
      "type": "image",
      "likesCount": 445,
      "caption": "New boots, new season, new goals! ⚽",
    },
    {
      "id": 5,
      "imageUrl":
          "https://images.pexels.com/photos/3621104/pexels-photo-3621104.jpeg?auto=compress&cs=tinysrgb&w=400",
      "type": "image",
      "likesCount": 678,
      "caption": "Stadium atmosphere is unmatched! 🏟️",
    },
    {
      "id": 6,
      "imageUrl":
          "https://images.pexels.com/photos/1618200/pexels-photo-1618200.jpeg?auto=compress&cs=tinysrgb&w=400",
      "type": "video",
      "likesCount": 892,
      "caption": "Behind the scenes training footage",
    },
  ];

  final List<Map<String, dynamic>> mutualFriends = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "avatar":
          "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=400",
    },
    {
      "id": 2,
      "name": "Mike Torres",
      "avatar":
          "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=400",
    },
    {
      "id": 3,
      "name": "Emma Wilson",
      "avatar":
          "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg?auto=compress&cs=tinysrgb&w=400",
    },
    {
      "id": 4,
      "name": "David Chen",
      "avatar":
          "https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=400",
    },
  ];

  final List<Map<String, dynamic>> suggestedFollows = [
    {
      "id": 1,
      "name": "Football Legends",
      "avatar":
          "https://images.pexels.com/photos/1884574/pexels-photo-1884574.jpeg?auto=compress&cs=tinysrgb&w=400",
      "mutualFriends": 12,
    },
    {
      "id": 2,
      "name": "Premier League",
      "avatar":
          "https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?auto=compress&cs=tinysrgb&w=400",
      "mutualFriends": 8,
    },
    {
      "id": 3,
      "name": "Football Skills",
      "avatar":
          "https://images.pexels.com/photos/114296/pexels-photo-114296.jpeg?auto=compress&cs=tinysrgb&w=400",
      "mutualFriends": 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Cover Photo
                    CoverPhotoWidget(
                      coverImageUrl: userData['coverPhoto'] as String,
                      onEditPressed: _handleCoverPhotoEdit,
                    ),

                    // Profile Header
                    ProfileHeaderWidget(
                      username: userData['username'] as String,
                      bio: userData['bio'] as String,
                      avatarUrl: userData['avatar'] as String,
                      followersCount: userData['followersCount'] as int,
                      followingCount: userData['followingCount'] as int,
                      onEditProfile: _handleEditProfile,
                      onCameraPressed: _handleAvatarUpdate,
                    ),

                    // User Stats
                    UserStatsWidget(
                      postsCount: userData['postsCount'] as int,
                      commentsCount: userData['commentsCount'] as int,
                      likesCount: userData['likesCount'] as int,
                    ),

                    // Posts Grid Header
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: Row(
                        children: [
                          Text(
                            'Posts',
                            style: AppTheme.darkTheme.textTheme.titleMedium
                                ?.copyWith(
                              color: AppTheme.pureWhiteText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          CustomIconWidget(
                            iconName: 'grid_view',
                            color: AppTheme.interactivePurple,
                            size: 6.w,
                          ),
                        ],
                      ),
                    ),

                    // Posts Grid
                    PostGridWidget(
                      posts: userPosts,
                      onPostTap: _handlePostTap,
                      onPostLongPress: _handlePostLongPress,
                    ),

                    SizedBox(height: 3.h),

                    // Social Connections
                    SocialConnectionsWidget(
                      mutualFriends: mutualFriends,
                      suggestedFollows: suggestedFollows,
                      onFriendTap: _handleFriendTap,
                      onFollowSuggestion: _handleFollowSuggestion,
                    ),

                    SizedBox(height: 10.h), // Bottom padding for tab bar
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        children: [
          Text(
            'Profile',
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.pureWhiteText,
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: _handleSettings,
            child: Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: AppTheme.surfaceGray,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: 'settings',
                color: AppTheme.pureWhiteText,
                size: 6.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 10.h,
      decoration: BoxDecoration(
        color: AppTheme.surfaceGray,
        border: Border(
          top: BorderSide(
            color: AppTheme.dividerColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTabItem('home', 'Home', 0),
          _buildTabItem('search', 'Search', 1),
          _buildTabItem('add_circle_outline', 'Post', 2),
          _buildTabItem('notifications', 'Notifications', 3),
          _buildTabItem('person', 'Profile', 4),
        ],
      ),
    );
  }

  Widget _buildTabItem(String iconName, String label, int index) {
    final bool isActive = _currentTabIndex == index;

    return GestureDetector(
      onTap: () => _handleTabTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: iconName,
              color:
                  isActive ? AppTheme.interactivePurple : AppTheme.neutralGray,
              size: 6.w,
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: isActive
                    ? AppTheme.interactivePurple
                    : AppTheme.neutralGray,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTabTap(int index) {
    if (index == _currentTabIndex) return;

    setState(() {
      _currentTabIndex = index;
    });

    // Navigate to different screens based on tab
    switch (index) {
      case 0:
        // Navigate to home/dashboard
        break;
      case 1:
        // Navigate to search
        break;
      case 2:
        // Navigate to create post
        break;
      case 3:
        // Navigate to notifications
        break;
      case 4:
        // Already on profile
        break;
    }
  }

  void _handleSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildSettingsBottomSheet(),
    );
  }

  Widget _buildSettingsBottomSheet() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.neutralGray,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 3.h),
          _buildSettingsItem('Privacy Settings', 'privacy_tip', () {}),
          _buildSettingsItem('Notification Settings', 'notifications', () {}),
          _buildSettingsItem('Account Management', 'manage_accounts', () {}),
          _buildSettingsItem('Theme Options', 'palette', () {}),
          Divider(color: AppTheme.dividerColor.withValues(alpha: 0.3)),
          _buildSettingsItem('Logout', 'logout', _handleLogout,
              isDestructive: true),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String title, String iconName, VoidCallback onTap,
      {bool isDestructive = false}) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: iconName,
        color: isDestructive ? AppTheme.errorRed : AppTheme.pureWhiteText,
        size: 6.w,
      ),
      title: Text(
        title,
        style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
          color: isDestructive ? AppTheme.errorRed : AppTheme.pureWhiteText,
        ),
      ),
      trailing: CustomIconWidget(
        iconName: 'chevron_right',
        color: AppTheme.neutralGray,
        size: 5.w,
      ),
      onTap: onTap,
    );
  }

  void _handleCoverPhotoEdit() {
    // Handle cover photo editing
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cover photo editing feature coming soon!'),
        backgroundColor: AppTheme.interactivePurple,
      ),
    );
  }

  void _handleEditProfile() {
    // Handle profile editing
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile editing feature coming soon!'),
        backgroundColor: AppTheme.interactivePurple,
      ),
    );
  }

  void _handleAvatarUpdate() {
    // Handle avatar update
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Avatar update feature coming soon!'),
        backgroundColor: AppTheme.interactivePurple,
      ),
    );
  }

  void _handlePostTap(Map<String, dynamic> post) {
    // Navigate to full post view
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening post: ${post['caption']}'),
        backgroundColor: AppTheme.interactivePurple,
      ),
    );
  }

  void _handlePostLongPress(Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildPostActionsBottomSheet(post),
    );
  }

  Widget _buildPostActionsBottomSheet(Map<String, dynamic> post) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.neutralGray,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 3.h),
          _buildPostActionItem('Edit Post', 'edit', () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Edit post feature coming soon!')),
            );
          }),
          _buildPostActionItem('Share Post', 'share', () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Share post feature coming soon!')),
            );
          }),
          _buildPostActionItem('Delete Post', 'delete', () {
            Navigator.pop(context);
            _showDeleteConfirmation(post);
          }, isDestructive: true),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildPostActionItem(String title, String iconName, VoidCallback onTap,
      {bool isDestructive = false}) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: iconName,
        color: isDestructive ? AppTheme.errorRed : AppTheme.pureWhiteText,
        size: 6.w,
      ),
      title: Text(
        title,
        style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
          color: isDestructive ? AppTheme.errorRed : AppTheme.pureWhiteText,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showDeleteConfirmation(Map<String, dynamic> post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceGray,
        title: Text(
          'Delete Post',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.pureWhiteText,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this post? This action cannot be undone.',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.neutralGray,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                userPosts.removeWhere((p) => p['id'] == post['id']);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Post deleted successfully')),
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(color: AppTheme.errorRed),
            ),
          ),
        ],
      ),
    );
  }

  void _handleFriendTap(Map<String, dynamic> friend) {
    // Navigate to friend's profile
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${friend['name']}\'s profile'),
        backgroundColor: AppTheme.interactivePurple,
      ),
    );
  }

  void _handleFollowSuggestion(Map<String, dynamic> suggestion) {
    // Handle follow suggestion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Following ${suggestion['name']}!'),
        backgroundColor: AppTheme.successGreen,
      ),
    );
  }

  void _handleLogout() {
    Navigator.pop(context); // Close bottom sheet
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceGray,
        title: Text(
          'Logout',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.pureWhiteText,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.neutralGray,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/welcome-screen',
                (route) => false,
              );
            },
            child: Text(
              'Logout',
              style: TextStyle(color: AppTheme.errorRed),
            ),
          ),
        ],
      ),
    );
  }
}
