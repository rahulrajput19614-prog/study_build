import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/bulk_actions_toolbar_widget.dart';
import './widgets/creation_options_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/filter_chip_widget.dart';
import './widgets/note_card_widget.dart';

class NotesManagement extends StatefulWidget {
  const NotesManagement({Key? key}) : super(key: key);

  @override
  State<NotesManagement> createState() => _NotesManagementState();
}

class _NotesManagementState extends State<NotesManagement>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  String _selectedFilter = 'My Notes';
  bool _isGridView = false;
  bool _isMultiSelectMode = false;
  bool _isSearchActive = false;
  final Set<int> _selectedNotes = <int>{};

  final List<Map<String, dynamic>> _mockNotes = [
    {
      'id': 1,
      'title': 'Quantum Physics Fundamentals',
      'preview':
          'Wave-particle duality is a fundamental concept in quantum mechanics that describes how every particle exhibits both wave and particle properties. This phenomenon was first observed in the double-slit experiment...',
      'subject': 'Physics',
      'contentType': 'text',
      'createdAt': '2 hours ago',
      'isBookmarked': true,
      'syncStatus': 'synced',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=400&h=300&fit=crop',
    },
    {
      'id': 2,
      'title': 'Organic Chemistry Reactions',
      'preview':
          'Substitution reactions in organic chemistry involve the replacement of one atom or group of atoms with another. SN1 and SN2 mechanisms are the two primary pathways...',
      'subject': 'Chemistry',
      'contentType': 'formula',
      'createdAt': '5 hours ago',
      'isBookmarked': false,
      'syncStatus': 'syncing',
      'thumbnailUrl': null,
    },
    {
      'id': 3,
      'title': 'Calculus Integration Techniques',
      'preview':
          'Integration by parts is a technique used to integrate products of functions. The formula is ∫u dv = uv - ∫v du, where u and dv are chosen strategically...',
      'subject': 'Mathematics',
      'contentType': 'text',
      'createdAt': '1 day ago',
      'isBookmarked': true,
      'syncStatus': 'synced',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=300&fit=crop',
    },
    {
      'id': 4,
      'title': 'Cell Division Process',
      'preview':
          'Mitosis is the process by which a single cell divides to produce two identical daughter cells. The process consists of several phases: prophase, metaphase, anaphase, and telophase...',
      'subject': 'Biology',
      'contentType': 'image',
      'createdAt': '2 days ago',
      'isBookmarked': false,
      'syncStatus': 'offline',
      'thumbnailUrl':
          'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400&h=300&fit=crop',
    },
    {
      'id': 5,
      'title': 'Voice Recording - History Notes',
      'preview':
          'Audio recording about World War II timeline and major events. Covers the period from 1939 to 1945 including key battles and political developments...',
      'subject': 'History',
      'contentType': 'voice',
      'createdAt': '3 days ago',
      'isBookmarked': true,
      'syncStatus': 'synced',
      'thumbnailUrl': null,
    },
  ];

  final List<Map<String, dynamic>> _filterOptions = [
    {'label': 'My Notes', 'count': 12},
    {'label': 'AI Generated', 'count': 8},
    {'label': 'Bookmarked', 'count': 5},
    {'label': 'Recent', 'count': 15},
  ];

  final List<Map<String, dynamic>> _templateSuggestions = [
    {
      'title': 'Physics Formula Sheet',
      'description': 'Create organized physics formulas',
      'icon': 'functions',
      'color': Color(0xFF2563EB),
    },
    {
      'title': 'Chemistry Lab Notes',
      'description': 'Document experiment procedures',
      'icon': 'science',
      'color': Color(0xFF059669),
    },
    {
      'title': 'Math Problem Solutions',
      'description': 'Step-by-step problem solving',
      'icon': 'calculate',
      'color': Color(0xFF7C3AED),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredNotes {
    List<Map<String, dynamic>> filtered = List.from(_mockNotes);

    // Apply filter
    switch (_selectedFilter) {
      case 'AI Generated':
        filtered =
            filtered.where((note) => note['contentType'] == 'ai').toList();
        break;
      case 'Bookmarked':
        filtered =
            filtered.where((note) => note['isBookmarked'] == true).toList();
        break;
      case 'Recent':
        // Already sorted by recent
        break;
      default:
        // My Notes - show all
        break;
    }

    // Apply search
    if (_searchController.text.isNotEmpty) {
      final searchTerm = _searchController.text.toLowerCase();
      filtered = filtered.where((note) {
        return (note['title'] as String).toLowerCase().contains(searchTerm) ||
            (note['preview'] as String).toLowerCase().contains(searchTerm) ||
            (note['subject'] as String).toLowerCase().contains(searchTerm);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              _buildAppBar(),
              _buildFilterChips(),
              Expanded(
                child: _filteredNotes.isEmpty
                    ? _buildEmptyState()
                    : _buildNotesList(),
              ),
            ],
          ),
          if (_isMultiSelectMode)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BulkActionsToolbarWidget(
                selectedCount: _selectedNotes.length,
                onSelectAll: _selectAllNotes,
                onDeselectAll: _deselectAllNotes,
                onDelete: _deleteSelectedNotes,
                onMove: _moveSelectedNotes,
                onShare: _shareSelectedNotes,
                onBookmark: _bookmarkSelectedNotes,
                onCancel: _exitMultiSelectMode,
              ),
            ),
        ],
      ),
      floatingActionButton: _isMultiSelectMode
          ? null
          : FloatingActionButton(
              onPressed: _showCreationOptions,
              child: CustomIconWidget(
                iconName: 'add',
                color: Colors.white,
                size: 6.w,
              ),
            ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Row(
                children: [
                  if (_isMultiSelectMode) ...[
                    GestureDetector(
                      onTap: _exitMultiSelectMode,
                      child: CustomIconWidget(
                        iconName: 'close',
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        size: 6.w,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${_selectedNotes.length} selected',
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ] else ...[
                    Text(
                      'Notes',
                      style:
                          AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: _toggleSearch,
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: _isSearchActive
                              ? AppTheme.lightTheme.primaryColor
                                  .withValues(alpha: 0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomIconWidget(
                          iconName: 'search',
                          color: _isSearchActive
                              ? AppTheme.lightTheme.primaryColor
                              : AppTheme.lightTheme.colorScheme.onSurface,
                          size: 6.w,
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    GestureDetector(
                      onTap: _toggleViewMode,
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomIconWidget(
                          iconName: _isGridView ? 'view_list' : 'grid_view',
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                          size: 6.w,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (_isSearchActive)
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 4.w).copyWith(bottom: 2.h),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search notes, subjects, or content...',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: CustomIconWidget(
                        iconName: 'search',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 5.w,
                      ),
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              setState(() {});
                            },
                            child: Padding(
                              padding: EdgeInsets.all(3.w),
                              child: CustomIconWidget(
                                iconName: 'clear',
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                                size: 5.w,
                              ),
                            ),
                          )
                        : null,
                  ),
                  autofocus: true,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 8.h,
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: _filterOptions.length,
        itemBuilder: (context, index) {
          final filter = _filterOptions[index];
          return FilterChipWidget(
            label: filter['label'] as String,
            count: filter['count'] as int,
            isSelected: _selectedFilter == filter['label'],
            onTap: () =>
                setState(() => _selectedFilter = filter['label'] as String),
          );
        },
      ),
    );
  }

  Widget _buildNotesList() {
    final notes = _filteredNotes;

    return RefreshIndicator(
      onRefresh: _refreshNotes,
      child: _isGridView
          ? GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 2.w,
                mainAxisSpacing: 2.h,
              ),
              itemCount: notes.length,
              itemBuilder: (context, index) => _buildNoteCard(notes[index]),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              itemCount: notes.length,
              itemBuilder: (context, index) => _buildNoteCard(notes[index]),
            ),
    );
  }

  Widget _buildNoteCard(Map<String, dynamic> note) {
    final noteId = note['id'] as int;
    final isSelected = _selectedNotes.contains(noteId);

    return NoteCardWidget(
      note: note,
      isSelected: isSelected,
      isMultiSelectMode: _isMultiSelectMode,
      onTap: () => _openNote(note),
      onEdit: () => _editNote(note),
      onShare: () => _shareNote(note),
      onMove: () => _moveNote(note),
      onDelete: () => _deleteNote(note),
      onSelectionChanged: (selected) => _toggleNoteSelection(noteId, selected),
    );
  }

  Widget _buildEmptyState() {
    return EmptyStateWidget(
      title:
          _searchController.text.isNotEmpty ? 'No notes found' : 'No notes yet',
      subtitle: _searchController.text.isNotEmpty
          ? 'Try adjusting your search terms or filters'
          : 'Start creating your first note to organize your study materials',
      buttonText: 'Create Note',
      onButtonPressed: _showCreationOptions,
      suggestions: _searchController.text.isEmpty ? _templateSuggestions : [],
    );
  }

  void _toggleSearch() {
    setState(() {
      _isSearchActive = !_isSearchActive;
      if (!_isSearchActive) {
        _searchController.clear();
      }
    });
  }

  void _toggleViewMode() {
    setState(() => _isGridView = !_isGridView);
  }

  void _toggleNoteSelection(int noteId, bool selected) {
    setState(() {
      if (selected) {
        _selectedNotes.add(noteId);
        if (!_isMultiSelectMode) {
          _isMultiSelectMode = true;
        }
      } else {
        _selectedNotes.remove(noteId);
        if (_selectedNotes.isEmpty) {
          _isMultiSelectMode = false;
        }
      }
    });
  }

  void _selectAllNotes() {
    setState(() {
      _selectedNotes.clear();
      _selectedNotes.addAll(_filteredNotes.map((note) => note['id'] as int));
    });
  }

  void _deselectAllNotes() {
    setState(() {
      _selectedNotes.clear();
      _isMultiSelectMode = false;
    });
  }

  void _exitMultiSelectMode() {
    setState(() {
      _selectedNotes.clear();
      _isMultiSelectMode = false;
    });
  }

  Future<void> _refreshNotes() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  void _showCreationOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreationOptionsWidget(
        onTextNote: () {
          Navigator.pop(context);
          _createTextNote();
        },
        onVoiceNote: () {
          Navigator.pop(context);
          _createVoiceNote();
        },
        onCameraScan: () {
          Navigator.pop(context);
          _createCameraScan();
        },
        onAIGenerate: () {
          Navigator.pop(context);
          _createAINote();
        },
        onClose: () => Navigator.pop(context),
      ),
    );
  }

  void _openNote(Map<String, dynamic> note) {
    // Navigate to note detail screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening note: ${note['title']}')),
    );
  }

  void _editNote(Map<String, dynamic> note) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Editing note: ${note['title']}')),
    );
  }

  void _shareNote(Map<String, dynamic> note) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sharing note: ${note['title']}')),
    );
  }

  void _moveNote(Map<String, dynamic> note) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Moving note: ${note['title']}')),
    );
  }

  void _deleteNote(Map<String, dynamic> note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: Text('Are you sure you want to delete "${note['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _mockNotes.removeWhere((n) => n['id'] == note['id']);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Note deleted')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _deleteSelectedNotes() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Notes'),
        content: Text(
            'Are you sure you want to delete ${_selectedNotes.length} notes?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _mockNotes
                    .removeWhere((note) => _selectedNotes.contains(note['id']));
                _selectedNotes.clear();
                _isMultiSelectMode = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notes deleted')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _moveSelectedNotes() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Moving ${_selectedNotes.length} notes')),
    );
  }

  void _shareSelectedNotes() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sharing ${_selectedNotes.length} notes')),
    );
  }

  void _bookmarkSelectedNotes() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bookmarking ${_selectedNotes.length} notes')),
    );
  }

  void _createTextNote() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Creating text note...')),
    );
  }

  void _createVoiceNote() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Starting voice recording...')),
    );
  }

  void _createCameraScan() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening camera for scanning...')),
    );
  }

  void _createAINote() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening AI note generator...')),
    );
  }
}
