import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/lecture_ui_model.dart';
import '../../shared/widgets/cards/lecture_card.dart';
import '../../shared/widgets/cards/processing_card.dart';
import '../../shared/widgets/dot_background.dart';
import '../../shared/widgets/inputs/ll_search_bar.dart';
import '../../shared/widgets/ll_app_bar.dart';
import '../../shared/widgets/mascot/cu_meo_empty_state.dart';
import '../../shared/widgets/navigation/ll_bottom_nav_bar.dart';
import '../../shared/widgets/skeleton/lecture_card_skeleton.dart';
import 'widgets/library_fab.dart';
import 'widgets/library_filter_tabs.dart';
import 'widgets/library_header.dart';

enum LibraryViewMode {
  normal,
  empty,
  skeleton,
}

/// !IMPORTANT: Màn Hình Thư Viện Bài Giảng (Home Screen)
/// CHỈ DẪN: Màn hình trung tâm của app. Tích hợp thanh tìm kiếm, bộ lọc phân loại,
/// danh sách bài giảng (Ready / Processing), FAB tải bản ghi và thanh điều hướng nổi.
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  LibraryViewMode _viewMode = LibraryViewMode.normal;
  LibraryFilter _currentFilter = LibraryFilter.all;
  String _searchQuery = '';
  int _currentNavIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isChromeVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Luôn hiện lại thanh điều hướng và FAB khi cuộn về đầu trang
    if (_scrollController.hasClients &&
        _scrollController.position.pixels <= 12 &&
        !_isChromeVisible) {
      setState(() => _isChromeVisible = true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  List<LectureUiModel> get _filteredLectures {
    return LectureUiModel.mockLectures.where((lec) {
      // Filter by chip
      if (_currentFilter == LibraryFilter.ready && lec.status != LectureStatus.ready) {
        return false;
      }
      if (_currentFilter == LibraryFilter.processing && lec.status != LectureStatus.processing) {
        return false;
      }
      if (_currentFilter == LibraryFilter.tech && !lec.subject.toLowerCase().contains('công nghệ') && !lec.tags.any((t) => t.toLowerCase().contains('web'))) {
        return false;
      }

      // Filter by search query
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchTitle = lec.title.toLowerCase().contains(query);
        final matchSubject = lec.subject.toLowerCase().contains(query);
        final matchSnippet = lec.stickySnippet?.toLowerCase().contains(query) ?? false;
        final matchTags = lec.tags.any((t) => t.toLowerCase().contains(query));
        return matchTitle || matchSubject || matchSnippet || matchTags;
      }

      return true;
    }).toList();
  }

  Future<void> _handleNavTap(int index) async {
    if (index == 0) {
      setState(() => _currentNavIndex = 0);
      return;
    }

    setState(() => _currentNavIndex = index);

    if (index == 1) {
      await context.push(AppConstants.routeSearch);
    } else if (index == 2) {
      final latestId = LectureUiModel.mockLectures.isNotEmpty
          ? LectureUiModel.mockLectures.first.id
          : 'lec_1';
      await context.push('/lecture/$latestId/ai');
    } else if (index == 3) {
      await context.push(AppConstants.routeSettings);
    }

    // Tự động khôi phục highlight về tab Thư viện khi người dùng quay lại
    if (mounted) {
      setState(() => _currentNavIndex = 0);
    }
  }

  String get _timeGreeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Chào buổi sáng ☀️';
    if (hour < 18) return 'Chào buổi chiều 🌤️';
    return 'Chào buổi tối 🌙';
  }

  @override
  Widget build(BuildContext context) {
    final lectures = _filteredLectures;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final bottomNavHeight = 60.0 + 12.0 + bottomInset;
    final fabBottom = bottomNavHeight + 14.0;

    return Scaffold(
      backgroundColor: AppColors.canvasCream,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: LlAppBar(
        title: 'LectureLens',
        subtitle: _timeGreeting,
        onNotificationTap: () => context.push(AppConstants.routeNotifications),
        onAvatarTap: () => context.push(AppConstants.routeSettings),
      ),
      body: DotBackground(
        child: Stack(
          children: [
            // Scrollable Content with Scroll-aware listener
            NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction == ScrollDirection.reverse) {
                  if (_isChromeVisible) {
                    setState(() => _isChromeVisible = false);
                  }
                } else if (notification.direction == ScrollDirection.forward) {
                  if (!_isChromeVisible) {
                    setState(() => _isChromeVisible = true);
                  }
                }
                return false;
              },
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Greeting (Duplicate avatar removed)
                          LibraryHeader(
                            greetingSubtitle: '$_timeGreeting • Bàn học hôm nay đã sẵn sàng!',
                          ),
                          const SizedBox(height: 14),

                          // Search Bar
                          LlSearchBar(
                            onChanged: (val) => setState(() => _searchQuery = val),
                            onTap: () {},
                            onMicTap: () => context.push(AppConstants.routeSearch),
                          ),
                          const SizedBox(height: 14),

                          // Horizontal Filter Chips
                          LibraryFilterTabs(
                            currentFilter: _currentFilter,
                            totalCount: LectureUiModel.mockLectures.length,
                            onFilterChanged: (filter) => setState(() => _currentFilter = filter),
                          ),
                          const SizedBox(height: 16),

                          // Section Title + Interactive Demo View Switcher
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bài giảng gần đây',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.onSurface,
                                      fontSize: 18,
                                    ),
                              ),
                              // Demo switchers (Normal, Empty, Skeleton) - Debug only
                              if (kDebugMode)
                                Container(
                                  padding: const EdgeInsets.all(2.5),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceContainerHigh,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Row(
                                    children: [
                                      _buildViewToggle(Icons.grid_view_rounded, LibraryViewMode.normal),
                                      _buildViewToggle(Icons.sentiment_satisfied_alt_rounded, LibraryViewMode.empty),
                                      _buildViewToggle(Icons.hourglass_top_rounded, LibraryViewMode.skeleton),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),

                  // Dynamic Body Content (Normal / Empty / Skeleton)
                  if (_viewMode == LibraryViewMode.skeleton)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => const Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: LectureCardSkeleton(),
                          ),
                          childCount: 3,
                        ),
                      ),
                    )
                  else if (_viewMode == LibraryViewMode.empty || lectures.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: CuMeoEmptyState(
                          title: 'Bàn học chưa có bài giảng nào',
                          subtitle: 'Cú Mèo đang ngủ trưa đợi bạn! Hãy tải lên bản ghi âm bài học đầu tiên để bắt đầu học tập nhé.',
                          buttonText: 'Tải bản ghi đầu tiên ☁️',
                          onButtonPressed: () => context.push(AppConstants.routeUpload),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, fabBottom + 64),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final lecture = lectures[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: lecture.status == LectureStatus.processing
                                  ? ProcessingCard(
                                      lecture: lecture,
                                      onCancel: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Đã hủy tác vụ xử lý.')),
                                        );
                                      },
                                    )
                                  : LectureCard(
                                      lecture: lecture,
                                      onTap: () => context.push('/lecture/${lecture.id}'),
                                      onPlayResumeTap: () => context.push('/lecture/${lecture.id}'),
                                      onBookmarkTap: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Đã lưu bài giảng "${lecture.title}"'),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      },
                                    ),
                            );
                          },
                          childCount: lectures.length,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Floating Upload Action Button (Positioned safely above bottom nav + Scroll Animation)
            Positioned(
              bottom: fabBottom,
              right: 16,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeInOutCubic,
                offset: _isChromeVisible ? Offset.zero : const Offset(0, 2.5),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  opacity: _isChromeVisible ? 1.0 : 0.0,
                  child: IgnorePointer(
                    ignoring: !_isChromeVisible,
                    child: LibraryFab(
                      onPressed: () => context.push(AppConstants.routeUpload),
                    ),
                  ),
                ),
              ),
            ),

            // Floating Bottom Navigation Bar (Centered + Scroll Animation)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeInOutCubic,
                offset: _isChromeVisible ? Offset.zero : const Offset(0, 1.5),
                child: IgnorePointer(
                  ignoring: !_isChromeVisible,
                  child: LlBottomNavBar(
                    currentIndex: _currentNavIndex,
                    onTabSelected: _handleNavTap,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewToggle(IconData icon, LibraryViewMode mode) {
    final isSelected = _viewMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _viewMode = mode),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surfaceCard : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: 15,
          color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}
