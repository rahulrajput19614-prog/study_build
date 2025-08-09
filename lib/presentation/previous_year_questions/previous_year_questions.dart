import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/empty_state_widget.dart';
import './widgets/exam_filter_chip.dart';
import './widgets/filter_bottom_sheet.dart';
import './widgets/question_card.dart';

class PreviousYearQuestions extends StatefulWidget {
  const PreviousYearQuestions({Key? key}) : super(key: key);

  @override
  State<PreviousYearQuestions> createState() => _PreviousYearQuestionsState();
}

class _PreviousYearQuestionsState extends State<PreviousYearQuestions>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isSearching = false;
  bool _isLoading = false;
  String _selectedExam = 'JEE';
  String _selectedYear = '2024';
  String _selectedSubject = 'All';
  Map<String, dynamic> _appliedFilters = {};
  List<String> _recentSearches = [
    'Thermodynamics',
    'Organic Chemistry',
    'Calculus'
  ];

  // Mock data for questions
  final List<Map<String, dynamic>> _allQuestions = [
    {
      "id": 1,
      "subject": "Physics",
      "year": 2024,
      "difficulty": "Medium",
      "questionText":
          "A particle moves in a circular path with constant angular velocity. What is the direction of acceleration?",
      "topics": ["Circular Motion", "Kinematics"],
      "attempts": 15,
      "isAttempted": true,
      "isBookmarked": false,
      "isIncorrect": false,
      "questionType": "MCQ",
      "exam": "JEE"
    },
    {
      "id": 2,
      "subject": "Chemistry",
      "year": 2024,
      "difficulty": "Hard",
      "questionText":
          "Which of the following compounds shows optical isomerism and has the molecular formula C4H8O2?",
      "topics": ["Organic Chemistry", "Isomerism"],
      "attempts": 8,
      "isAttempted": false,
      "isBookmarked": true,
      "isIncorrect": false,
      "questionType": "MCQ",
      "exam": "JEE"
    },
    {
      "id": 3,
      "subject": "Mathematics",
      "year": 2023,
      "difficulty": "Easy",
      "questionText":
          "Find the derivative of sin(x²) with respect to x using chain rule.",
      "topics": ["Calculus", "Differentiation"],
      "attempts": 25,
      "isAttempted": true,
      "isBookmarked": true,
      "isIncorrect": true,
      "questionType": "Numerical",
      "exam": "JEE"
    },
    {
      "id": 4,
      "subject": "Biology",
      "year": 2024,
      "difficulty": "Medium",
      "questionText":
          "Which enzyme is responsible for the conversion of glucose to glucose-6-phosphate in glycolysis?",
      "topics": ["Metabolism", "Enzymes"],
      "attempts": 12,
      "isAttempted": false,
      "isBookmarked": false,
      "isIncorrect": false,
      "questionType": "MCQ",
      "exam": "NEET"
    },
    {
      "id": 5,
      "subject": "History",
      "year": 2023,
      "difficulty": "Hard",
      "questionText":
          "Analyze the impact of the Sepoy Mutiny of 1857 on British colonial policies in India.",
      "topics": ["Modern History", "Colonial India"],
      "attempts": 6,
      "isAttempted": false,
      "isBookmarked": false,
      "isIncorrect": false,
      "questionType": "Assertion-Reason",
      "exam": "UPSC"
    },
    {
      "id": 6,
      "subject": "Geography",
      "year": 2024,
      "difficulty": "Medium",
      "questionText":
          "What are the major factors affecting the distribution of natural vegetation in India?",
      "topics": ["Physical Geography", "Vegetation"],
      "attempts": 18,
      "isAttempted": true,
      "isBookmarked": false,
      "isIncorrect": false,
      "questionType": "MCQ",
      "exam": "UPSC"
    }
  ];

  List<Map<String, dynamic>> _filteredQuestions = [];
  final List<String> _examTypes = ['JEE', 'NEET', 'UPSC', 'CAT', 'GATE'];
  final List<String> _years = ['2024', '2023', '2022', '2021', '2020'];
  final List<String> _subjects = [
    'All',
    'Physics',
    'Chemistry',
    'Mathematics',
    'Biology',
    'History',
    'Geography',
    'Economics',
    'Polity'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _filteredQuestions = List.from(_allQuestions);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreQuestions();
    }
  }

  void _loadMoreQuestions() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulate loading more questions
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  void _filterQuestions() {
    setState(() {
      _filteredQuestions = _allQuestions.where((question) {
        // Filter by exam
        if (question['exam'] != _selectedExam) return false;

        // Filter by year
        if (_selectedYear != 'All' &&
            question['year'].toString() != _selectedYear) return false;

        // Filter by subject
        if (_selectedSubject != 'All' &&
            question['subject'] != _selectedSubject) return false;

        // Apply advanced filters
        if (_appliedFilters.isNotEmpty) {
          // Difficulty filter
          if (_appliedFilters['difficulties'] != null &&
              (_appliedFilters['difficulties'] as List).isNotEmpty &&
              !(_appliedFilters['difficulties'] as List)
                  .contains(question['difficulty'])) {
            return false;
          }

          // Question type filter
          if (_appliedFilters['questionTypes'] != null &&
              (_appliedFilters['questionTypes'] as List).isNotEmpty &&
              !(_appliedFilters['questionTypes'] as List)
                  .contains(question['questionType'])) {
            return false;
          }

          // Solved status filter
          if (_appliedFilters['solvedStatus'] != null) {
            switch (_appliedFilters['solvedStatus']) {
              case 'Solved':
                if (!(question['isAttempted'] ?? false)) return false;
                break;
              case 'Unsolved':
                if (question['isAttempted'] ?? false) return false;
                break;
              case 'Incorrect':
                if (!(question['isIncorrect'] ?? false)) return false;
                break;
            }
          }

          // Topics filter
          if (_appliedFilters['topics'] != null &&
              (_appliedFilters['topics'] as List).isNotEmpty) {
            final questionTopics = question['topics'] as List<String>;
            final selectedTopics = _appliedFilters['topics'] as List<String>;
            if (!selectedTopics
                .any((topic) => questionTopics.contains(topic))) {
              return false;
            }
          }
        }

        // Search filter
        if (_searchController.text.isNotEmpty) {
          final searchTerm = _searchController.text.toLowerCase();
          final questionText =
              (question['questionText'] as String).toLowerCase();
          final topics =
              (question['topics'] as List<String>).join(' ').toLowerCase();
          final subject = (question['subject'] as String).toLowerCase();

          if (!questionText.contains(searchTerm) &&
              !topics.contains(searchTerm) &&
              !subject.contains(searchTerm)) {
            return false;
          }
        }

        return true;
      }).toList();
    });
  }

  void _onSearchChanged(String value) {
    _filterQuestions();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _filterQuestions();
      }
    });
  }

  void _onRecentSearchTap(String search) {
    _searchController.text = search;
    _filterQuestions();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        currentFilters: _appliedFilters,
        onApplyFilters: (filters) {
          setState(() {
            _appliedFilters = filters;
          });
          _filterQuestions();
        },
      ),
    );
  }

  void _onQuestionTap(Map<String, dynamic> question) {
    // Navigate to question detail view
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Opening question: ${question['questionText'].substring(0, 30)}...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onBookmarkTap(Map<String, dynamic> question) {
    setState(() {
      question['isBookmarked'] = !(question['isBookmarked'] ?? false);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(question['isBookmarked']
            ? 'Question bookmarked!'
            : 'Bookmark removed'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _onPracticeTap(Map<String, dynamic> question) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting practice mode for ${question['subject']}'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onAddToTestTap(Map<String, dynamic> question) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Question added to custom test'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate refresh
    await Future.delayed(Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      _filterQuestions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: 0,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search questions, topics...',
                  border: InputBorder.none,
                  hintStyle: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
                style: AppTheme.lightTheme.textTheme.bodyMedium,
                onChanged: _onSearchChanged,
              )
            : Text(
                'Previous Year Questions',
                style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
              ),
        actions: [
          IconButton(
            onPressed: _toggleSearch,
            icon: CustomIconWidget(
              iconName: _isSearching ? 'close' : 'search',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Home'),
            Tab(text: 'PYQ'),
            Tab(text: 'Tests'),
          ],
          labelColor: AppTheme.lightTheme.primaryColor,
          unselectedLabelColor:
              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          indicatorColor: AppTheme.lightTheme.primaryColor,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Home tab placeholder
          Center(
            child: Text(
              'Home Content',
              style: AppTheme.lightTheme.textTheme.titleMedium,
            ),
          ),
          // PYQ tab (main content)
          RefreshIndicator(
            onRefresh: () => _onRefresh(),
            child: Column(
              children: [
                // Search suggestions (when searching)
                if (_isSearching && _searchController.text.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4.w),
                    color: AppTheme.lightTheme.colorScheme.surface,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Searches',
                          style: AppTheme.lightTheme.textTheme.titleSmall
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Wrap(
                          spacing: 2.w,
                          runSpacing: 1.h,
                          children: _recentSearches
                              .map((search) => GestureDetector(
                                    onTap: () => _onRecentSearchTap(search),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.w, vertical: 1.h),
                                      decoration: BoxDecoration(
                                        color: AppTheme.lightTheme.colorScheme
                                            .primaryContainer,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomIconWidget(
                                            iconName: 'history',
                                            color: AppTheme.lightTheme
                                                .colorScheme.onPrimaryContainer,
                                            size: 16,
                                          ),
                                          SizedBox(width: 1.w),
                                          Text(
                                            search,
                                            style: AppTheme.lightTheme.textTheme
                                                .labelMedium
                                                ?.copyWith(
                                              color: AppTheme
                                                  .lightTheme
                                                  .colorScheme
                                                  .onPrimaryContainer,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                // Filter chips
                if (!_isSearching || _searchController.text.isNotEmpty)
                  Container(
                    height: 8.h,
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      children: [
                        // Exam filter
                        ..._examTypes.map((exam) => ExamFilterChip(
                              label: exam,
                              isSelected: _selectedExam == exam,
                              onTap: () {
                                setState(() {
                                  _selectedExam = exam;
                                });
                                _filterQuestions();
                              },
                            )),
                        // Year filter
                        ..._years.map((year) => ExamFilterChip(
                              label: year,
                              isSelected: _selectedYear == year,
                              onTap: () {
                                setState(() {
                                  _selectedYear = year;
                                });
                                _filterQuestions();
                              },
                            )),
                        // Subject filter
                        ..._subjects.map((subject) => ExamFilterChip(
                              label: subject,
                              isSelected: _selectedSubject == subject,
                              onTap: () {
                                setState(() {
                                  _selectedSubject = subject;
                                });
                                _filterQuestions();
                              },
                            )),
                      ],
                    ),
                  ),
                // Questions list
                Expanded(
                  child: _filteredQuestions.isEmpty
                      ? EmptyStateWidget(
                          subject:
                              _selectedSubject == 'All' ? '' : _selectedSubject,
                          onRefresh: _onRefresh,
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              _filteredQuestions.length + (_isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == _filteredQuestions.length) {
                              return Container(
                                padding: EdgeInsets.all(4.w),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppTheme.lightTheme.primaryColor,
                                  ),
                                ),
                              );
                            }

                            final question = _filteredQuestions[index];
                            return QuestionCard(
                              question: question,
                              onTap: () => _onQuestionTap(question),
                              onBookmark: () => _onBookmarkTap(question),
                              onPractice: () => _onPracticeTap(question),
                              onAddToTest: () => _onAddToTestTap(question),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          // Tests tab placeholder
          Center(
            child: Text(
              'Tests Content',
              style: AppTheme.lightTheme.textTheme.titleMedium,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFilterBottomSheet,
        backgroundColor: AppTheme.lightTheme.primaryColor,
        child: CustomIconWidget(
          iconName: 'tune',
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
