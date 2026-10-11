import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/lecture_ui_model.dart';
import '../../shared/widgets/audio/audio_player_capsule.dart';
import '../../shared/widgets/dot_background.dart';
import '../../shared/widgets/ll_app_bar.dart';
import '../../shared/widgets/skeleton/lecture_detail_skeleton.dart';
import 'widgets/tabs/ai_qa_tab.dart';
import 'widgets/tabs/table_of_contents_tab.dart';
import 'widgets/tabs/transcript_tab.dart';

/// !IMPORTANT: Màn Hình Chi Tiết Bài Giảng (Lecture Detail Screen)
/// CHỈ DẪN: Kết nối bộ phát âm thanh nổi AudioPlayerCapsule, 3 Tabs nội dung:
/// 1. Bản ghi (Transcripts)
/// 2. Hỏi đáp AI (Chat trích dẫn)
/// 3. Mục lục (TOC phân đoạn chủ đề)
class LectureDetailScreen extends StatefulWidget {
  final String lectureId;
  final int initialTabIndex;
  final int? highlightSeconds;
  final String? highlightText;

  const LectureDetailScreen({
    super.key,
    required this.lectureId,
    this.initialTabIndex = 0,
    this.highlightSeconds,
    this.highlightText,
  });

  @override
  State<LectureDetailScreen> createState() => _LectureDetailScreenState();
}

class _LectureDetailScreenState extends State<LectureDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late LectureUiModel _lecture;
  bool _isLoadingSkeleton = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex.clamp(0, 2),
    );

    _lecture = LectureUiModel.mockLectures.firstWhere(
      (l) => l.id == widget.lectureId,
      orElse: () => LectureUiModel.mockLectures.first,
    );

    if (widget.highlightSeconds != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final min = widget.highlightSeconds! ~/ 60;
        final sec = (widget.highlightSeconds! % 60).toString().padLeft(2, '0');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✨ Đang làm nổi bật đoạn trích tìm kiếm tại mốc $min:$sec'),
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _seekAudio(int seconds) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang tua đến vị trí ${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasCream,
      appBar: LlAppBar(
        title: _lecture.title,
        subtitle: '${_lecture.subject} • ${_lecture.university}',
        showBack: true,
        showNotifications: false,
        actions: [
          // Skeleton toggle demo (Debug mode only)
          if (kDebugMode)
            IconButton(
              icon: Icon(
                _isLoadingSkeleton ? Icons.visibility : Icons.hourglass_top_rounded,
                size: 20,
                color: AppColors.primary,
              ),
              tooltip: 'Xem Shimmer Skeleton',
              onPressed: () => setState(() => _isLoadingSkeleton = !_isLoadingSkeleton),
            ),
          IconButton(
            icon: const Icon(Icons.share_outlined, size: 20),
            color: AppColors.onSurface,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã sao chép liên kết chia sẻ bài giảng.')),
              );
            },
          ),
        ],
      ),
      body: DotBackground(
        child: SafeArea(
          child: _isLoadingSkeleton
              ? const LectureDetailSkeleton()
              : Column(
                  children: [
                    // Top Audio Player Capsule
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      child: AudioPlayerCapsule(
                        title: _lecture.title,
                        subtitle: '${_lecture.subject} • 45:20 phút',
                        totalDuration: Duration(seconds: _lecture.durationSeconds),
                        initialPosition: Duration(seconds: _lecture.resumePositionSeconds ?? 0),
                      ),
                    ),

                    // Custom Tab Bar (Stationery Pill Styling)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryContainer.withOpacity(0.24),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: AppColors.onSurfaceVariant,
                        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        tabs: [
                          const Tab(text: 'Bản ghi'),
                          const Tab(text: 'Hỏi đáp AI ✨'),
                          Tab(text: 'Mục lục (${_lecture.topics.length})'),
                        ],
                      ),
                    ),

                    // Tab Views
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          TranscriptTab(
                            segments: _lecture.transcripts,
                            highlightSeconds: widget.highlightSeconds,
                            onSeekSeconds: _seekAudio,
                          ),
                          AiQaTab(
                            initialMessages: _lecture.aiMessages,
                            onSeekSeconds: _seekAudio,
                          ),
                          TableOfContentsTab(
                            topics: _lecture.topics,
                            onSeekSeconds: _seekAudio,
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
}
