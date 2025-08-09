import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/achievement_badges.dart';
import './widgets/recent_activity_timeline.dart';
import './widgets/settings_section.dart';
import './widgets/study_goals_card.dart';
import './widgets/study_statistics_card.dart';
import './widgets/user_avatar_section.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;

  // Mock user data
  final Map<String, dynamic> _userData = {
    "name": "Alex Johnson",
    "selectedExam": "JEE Main 2025",
    "studyStreak": 15,
    "avatar":
        "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&crop=face",
    "testsCompleted": 32,
    "storiesGenerated": 18,
    "studyDays": 78,
    "totalStudyTime": 156,
    "weeklyActivity": [3.5, 4.2, 2.8, 5.1, 3.9, 4.7, 2.3],
    "favoriteSubjects": ["Physics", "Mathematics", "Chemistry"],
    "dailyGoal": 120,
    "currentProgress": 85,
    "motivationalMessage": "You're doing great! Keep pushing forward! 💪"
  };

  final List<Map<String, dynamic>> _recentActivities = [
    {
      "icon": "quiz",
      "title": "Mock Test Completed",
      "description": "JEE Main Physics - Chapter 12",
      "timestamp": "2 hours ago",
      "type": "test"
    },
    {
      "icon": "auto_stories",
      "title": "Story Generated",
      "description": "AI created a story about quantum mechanics",
      "timestamp": "5 hours ago",
      "type": "story"
    },
    {
      "icon": "book",
      "title": "Study Session",
      "description": "Completed 45 minutes of Mathematics",
      "timestamp": "1 day ago",
      "type": "study"
    },
    {
      "icon": "emoji_events",
      "title": "Achievement Unlocked",
      "description": "Completed 30 practice tests milestone",
      "timestamp": "2 days ago",
      "type": "achievement"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this, initialIndex: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showSettingsBottomSheet,
            icon: CustomIconWidget(
              iconName: 'settings',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 6.w,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          onTap: (index) {
            if (index != 5) {
              _navigateToTab(index);
            }
          },
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'app_registration',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 4.w,
                  ),
                  SizedBox(width: 1.w),
                  Text('Sign Up', style: TextStyle(fontSize: 10.sp)),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'home',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 4.w,
                  ),
                  SizedBox(width: 1.w),
                  Text('Home', style: TextStyle(fontSize: 10.sp)),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'quiz',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 4.w,
                  ),
                  SizedBox(width: 1.w),
                  Text('PYQ', style: TextStyle(fontSize: 10.sp)),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'timer',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 4.w,
                  ),
                  SizedBox(width: 1.w),
                  Text('Mock Test', style: TextStyle(fontSize: 10.sp)),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'note',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 4.w,
                  ),
                  SizedBox(width: 1.w),
                  Text('Notes', style: TextStyle(fontSize: 10.sp)),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'person',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 4.w,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppTheme.lightTheme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProfile,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              UserAvatarSection(
                userName: _userData["name"] as String,
                selectedExam: _userData["selectedExam"] as String,
                studyStreak: _userData["studyStreak"] as int,
                avatarUrl: _userData["avatar"] as String,
                onAvatarTap: _selectProfilePhoto,
              ),
              SizedBox(height: 4.h),
              AchievementBadges(
                testsCompleted: _userData["testsCompleted"] as int,
                storiesGenerated: _userData["storiesGenerated"] as int,
                studyDays: _userData["studyDays"] as int,
              ),
              SizedBox(height: 4.h),
              StudyStatisticsCard(
                weeklyActivity:
                    (_userData["weeklyActivity"] as List).cast<double>(),
                totalStudyTime: _userData["totalStudyTime"] as int,
                favoriteSubjects:
                    (_userData["favoriteSubjects"] as List).cast<String>(),
              ),
              SizedBox(height: 4.h),
              StudyGoalsCard(
                dailyGoal: _userData["dailyGoal"] as int,
                currentProgress: _userData["currentProgress"] as int,
                motivationalMessage: _userData["motivationalMessage"] as String,
                onSetGoal: _showSetGoalDialog,
              ),
              SizedBox(height: 4.h),
              RecentActivityTimeline(
                activities: _recentActivities,
              ),
              SizedBox(height: 4.h),
              SettingsSection(
                isDarkMode: _isDarkMode,
                notificationsEnabled: _notificationsEnabled,
                selectedExam: _userData["selectedExam"] as String,
                onDarkModeToggle: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  _showSnackBar(
                      _isDarkMode ? 'Dark mode enabled' : 'Light mode enabled');
                },
                onNotificationToggle: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                  _showSnackBar(_notificationsEnabled
                      ? 'Notifications enabled'
                      : 'Notifications disabled');
                },
                onExamSelection: _showExamSelectionDialog,
                onAccountSettings: _showAccountSettings,
              ),
              SizedBox(height: 4.h),
              _buildActionButtons(),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showQuickActions,
        child: CustomIconWidget(
          iconName: 'add',
          color: Colors.white,
          size: 6.w,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _shareProfile,
            icon: CustomIconWidget(
              iconName: 'share',
              color: Colors.white,
              size: 5.w,
            ),
            label: Text('Share Profile'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 2.h),
            ),
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _exportStudyData,
            icon: CustomIconWidget(
              iconName: 'download',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 5.w,
            ),
            label: Text('Export Study Data'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 2.h),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToTab(int index) {
    final routes = [
      '/sign-up-screen',
      '/home-screen',
      '/previous-year-questions',
      '/mock-test-interface',
      '/notes-management',
    ];

    if (index < routes.length) {
      Navigator.pushNamed(context, routes[index]);
    }
  }

  Future<void> _refreshProfile() async {
    await Future.delayed(const Duration(seconds: 2));
    _showSnackBar('Profile updated successfully');
  }

  void _selectProfilePhoto() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Change Profile Photo',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showSnackBar('Camera feature coming soon');
                    },
                    icon: CustomIconWidget(
                      iconName: 'camera_alt',
                      color: Colors.white,
                      size: 5.w,
                    ),
                    label: Text('Camera'),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showSnackBar('Gallery feature coming soon');
                    },
                    icon: CustomIconWidget(
                      iconName: 'photo_library',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 5.w,
                    ),
                    label: Text('Gallery'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _showSetGoalDialog() {
    int newGoal = _userData["dailyGoal"] as int;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Set Daily Study Goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Current goal: ${_userData["dailyGoal"]} minutes'),
            SizedBox(height: 2.h),
            Slider(
              value: newGoal.toDouble(),
              min: 30,
              max: 300,
              divisions: 27,
              label: '$newGoal minutes',
              onChanged: (value) {
                setState(() {
                  newGoal = value.toInt();
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _userData["dailyGoal"] = newGoal;
              });
              Navigator.pop(context);
              _showSnackBar('Daily goal updated to $newGoal minutes');
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showExamSelectionDialog() {
    final exams = [
      'JEE Main 2025',
      'JEE Advanced 2025',
      'NEET 2025',
      'UPSC CSE',
      'CAT 2025'
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Exam'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: exams
              .map((exam) => RadioListTile<String>(
                    title: Text(exam),
                    value: exam,
                    groupValue: _userData["selectedExam"] as String,
                    onChanged: (value) {
                      setState(() {
                        _userData["selectedExam"] = value!;
                      });
                      Navigator.pop(context);
                      _showSnackBar('Exam updated to $value');
                    },
                  ))
              .toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showAccountSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              Text(
                'Account Settings',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 3.h),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    ListTile(
                      leading: CustomIconWidget(
                        iconName: 'privacy_tip',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 6.w,
                      ),
                      title: Text('Privacy Settings'),
                      subtitle: Text('Manage data sharing and visibility'),
                      trailing: CustomIconWidget(
                        iconName: 'chevron_right',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 5.w,
                      ),
                      onTap: () =>
                          _showSnackBar('Privacy settings coming soon'),
                    ),
                    ListTile(
                      leading: CustomIconWidget(
                        iconName: 'sync',
                        color: AppTheme.lightTheme.colorScheme.secondary,
                        size: 6.w,
                      ),
                      title: Text('Sync Status'),
                      subtitle: Text('Last synced: 2 hours ago'),
                      trailing: CustomIconWidget(
                        iconName: 'chevron_right',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 5.w,
                      ),
                      onTap: () => _showSnackBar('Syncing data...'),
                    ),
                    ListTile(
                      leading: CustomIconWidget(
                        iconName: 'delete_forever',
                        color: AppTheme.lightTheme.colorScheme.error,
                        size: 6.w,
                      ),
                      title: Text('Delete Account'),
                      subtitle: Text('Permanently delete your account'),
                      trailing: CustomIconWidget(
                        iconName: 'chevron_right',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 5.w,
                      ),
                      onTap: _showDeleteAccountDialog,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Text(
            'Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              _showSnackBar('Account deletion cancelled');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.lightTheme.colorScheme.error,
            ),
            child: Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSettingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quick Settings',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            SwitchListTile(
              title: Text('Dark Mode'),
              subtitle: Text('Switch to dark theme'),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
                Navigator.pop(context);
                _showSnackBar(
                    _isDarkMode ? 'Dark mode enabled' : 'Light mode enabled');
              },
            ),
            SwitchListTile(
              title: Text('Notifications'),
              subtitle: Text('Study reminders and updates'),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                Navigator.pop(context);
                _showSnackBar(_notificationsEnabled
                    ? 'Notifications enabled'
                    : 'Notifications disabled');
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quick Actions',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/mock-test-interface');
                    },
                    icon: CustomIconWidget(
                      iconName: 'timer',
                      color: Colors.white,
                      size: 5.w,
                    ),
                    label: Text('Start Test'),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/notes-management');
                    },
                    icon: CustomIconWidget(
                      iconName: 'note_add',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 5.w,
                    ),
                    label: Text('Add Note'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _shareProfile() {
    _showSnackBar('Profile sharing feature coming soon');
  }

  void _exportStudyData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Export Study Data'),
        content: Text('Choose the format for your study data export:'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('PDF export started...');
            },
            child: Text('Export PDF'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.w),
        ),
      ),
    );
  }
}
