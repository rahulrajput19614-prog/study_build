import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/daily_goal_card.dart';
import './widgets/floating_action_menu.dart';
import './widgets/quick_action_item.dart';
import './widgets/recent_activity_card.dart';
import './widgets/recommended_content_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentStreak = 7;
  double _dailyProgress = 65.0;

  // Mock data for recent activities
  final List<Map<String, dynamic>> _recentActivities = [
    {
      "id": 1,
      "title": "The Quantum Physics Adventure",
      "subtitle": "Generated story about wave-particle duality",
      "type": "Story",
      "timestamp": "2 hours ago",
    },
    {
      "id": 2,
      "title": "JEE Main Mock Test #15",
      "subtitle": "Physics & Chemistry - Score: 85/100",
      "type": "Test",
      "timestamp": "5 hours ago",
    },
    {
      "id": 3,
      "title": "Organic Chemistry Notes",
      "subtitle": "Reaction mechanisms and synthesis",
      "type": "Note",
      "timestamp": "1 day ago",
    },
    {
      "id": 4,
      "title": "Mathematics Practice Quiz",
      "subtitle": "Calculus and Integration - Score: 92/100",
      "type": "Test",
      "timestamp": "2 days ago",
    },
  ];

  // Mock data for recommended content
  final List<Map<String, dynamic>> _recommendedContent = [
    {
      "id": 1,
      "title": "Advanced Calculus Mastery",
      "description":
          "Master integration techniques and differential equations with step-by-step explanations and practice problems.",
      "imageUrl":
          "https://images.unsplash.com/photo-1635070041078-e363dbe005cb?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "category": "Mathematics",
      "duration": 45,
      "rating": 4.8,
      "isBookmarked": false,
    },
    {
      "id": 2,
      "title": "Organic Chemistry Reactions",
      "description":
          "Comprehensive guide to organic reaction mechanisms, synthesis pathways, and molecular interactions.",
      "imageUrl":
          "https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "category": "Chemistry",
      "duration": 60,
      "rating": 4.9,
      "isBookmarked": true,
    },
    {
      "id": 3,
      "title": "Modern Physics Concepts",
      "description":
          "Explore quantum mechanics, relativity, and atomic structure with interactive simulations and examples.",
      "imageUrl":
          "https://images.unsplash.com/photo-1446776653964-20c1d3a81b06?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "category": "Physics",
      "duration": 50,
      "rating": 4.7,
      "isBookmarked": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreContent();
    }
  }

  Future<void> _loadMoreContent() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate loading more content
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refreshContent() async {
    setState(() {
      _dailyProgress = (_dailyProgress + 10).clamp(0, 100);
      if (_dailyProgress >= 100) {
        _currentStreak++;
        _dailyProgress = 0;
      }
    });

    await Future.delayed(const Duration(seconds: 1));
  }

  void _showFloatingActionMenu() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FloatingActionMenu(
        onGenerateStory: () {
          // Navigate to story generation screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Opening AI Story Generator...')),
          );
        },
        onAddNote: () {
          Navigator.pushNamed(context, '/notes-management');
        },
        onStartQuiz: () {
          Navigator.pushNamed(context, '/mock-test-interface');
        },
      ),
    );
  }

  void _toggleBookmark(int contentId) {
    setState(() {
      final contentIndex = _recommendedContent
          .indexWhere((content) => (content["id"] as int) == contentId);
      if (contentIndex != -1) {
        _recommendedContent[contentIndex]["isBookmarked"] =
            !(_recommendedContent[contentIndex]["isBookmarked"] as bool);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning!',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              'Ready to learn?',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No new notifications')),
                  );
                },
                icon: CustomIconWidget(
                  iconName: 'notifications_outlined',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 24,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/user-profile');
            },
            icon: CustomIconWidget(
              iconName: 'person_outline',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshContent,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Daily Goal Card
            SliverToBoxAdapter(
              child: DailyGoalCard(
                currentStreak: _currentStreak,
                progressPercentage: _dailyProgress,
                motivationalMessage: _dailyProgress >= 80
                    ? "Almost there! You're doing great!"
                    : "Keep going! Every step counts!",
              ),
            ),

            // Quick Actions Grid
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Actions',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 3.w,
                      mainAxisSpacing: 2.h,
                      childAspectRatio: 1.2,
                      children: [
                        QuickActionItem(
                          title: 'AI Story Generator',
                          iconName: 'auto_stories',
                          backgroundColor:
                              AppTheme.lightTheme.colorScheme.secondary,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Opening AI Story Generator...')),
                            );
                          },
                        ),
                        QuickActionItem(
                          title: 'PYQ Browser',
                          iconName: 'quiz',
                          backgroundColor:
                              AppTheme.lightTheme.colorScheme.tertiary,
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/previous-year-questions');
                          },
                        ),
                        QuickActionItem(
                          title: 'Mock Tests',
                          iconName: 'assignment',
                          backgroundColor:
                              AppTheme.lightTheme.colorScheme.primary,
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/mock-test-interface');
                          },
                        ),
                        QuickActionItem(
                          title: 'Notes',
                          iconName: 'note',
                          backgroundColor: Colors.orange,
                          onTap: () {
                            Navigator.pushNamed(context, '/notes-management');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Recent Activity Section
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Activity',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('View all activities')),
                            );
                          },
                          child: Text(
                            'View All',
                            style: AppTheme.lightTheme.textTheme.labelMedium
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      itemCount: _recentActivities.length,
                      itemBuilder: (context, index) {
                        final activity = _recentActivities[index];
                        return RecentActivityCard(
                          title: activity["title"] as String,
                          subtitle: activity["subtitle"] as String,
                          type: activity["type"] as String,
                          timestamp: activity["timestamp"] as String,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Opening ${activity["title"]}')),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Recommended Content Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Text(
                  'Recommended for You',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final content = _recommendedContent[index];
                  return RecommendedContentCard(
                    title: content["title"] as String,
                    description: content["description"] as String,
                    imageUrl: content["imageUrl"] as String,
                    category: content["category"] as String,
                    duration: content["duration"] as int,
                    rating: (content["rating"] as num).toDouble(),
                    isBookmarked: content["isBookmarked"] as bool,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Opening ${content["title"]}')),
                      );
                    },
                    onBookmark: () => _toggleBookmark(content["id"] as int),
                  );
                },
                childCount: _recommendedContent.length,
              ),
            ),

            // Loading indicator
            if (_isLoading)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),

            // Bottom spacing
            SliverToBoxAdapter(
              child: SizedBox(height: 10.h),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFloatingActionMenu,
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        child: CustomIconWidget(
          iconName: 'add',
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
