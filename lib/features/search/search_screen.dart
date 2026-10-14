import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/search_result_ui_model.dart';
import '../../shared/widgets/dot_background.dart';
import '../../shared/widgets/inputs/ll_search_bar.dart';
import '../../shared/widgets/ll_app_bar.dart';
import '../../shared/widgets/mascot/cu_meo_empty_state.dart';
import 'widgets/search_cu_meo_tip.dart';
import 'widgets/search_recent_chips.dart';
import 'widgets/search_result_item.dart';

/// !IMPORTANT: Màn Hình Tìm Kiếm Toàn Cục (Global Search Screen)
/// CHỈ DẪN: Tìm kiếm theo từ khóa xuyên suốt tất cả bản ghi âm bài giảng,
/// hiển thị trích dẫn mốc thời gian và mẹo tìm kiếm từ Cú Mèo.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  final List<String> _recentSearches = const [
    'JWT Authentication',
    'HMAC-SHA256',
    'P-Value < 0.05',
    'Pipeline Hazard',
    'RESTful API',
  ];

  List<SearchResultUiModel> get _results {
    if (_query.trim().isEmpty) return [];
    final q = _query.toLowerCase();
    return SearchResultUiModel.mockResults.where((r) {
      return r.lectureTitle.toLowerCase().contains(q) ||
          r.snippet.toLowerCase().contains(q) ||
          r.subject.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const LlAppBar(
        title: 'Tìm kiếm toàn cục',
        subtitle: 'Kho kiến thức bài giảng',
        showBack: true,
        showNotifications: false,
      ),
      body: DotBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: LlSearchBar(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _query = val),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_query.isEmpty) ...[
                        const SearchCuMeoTip()
                            .animate()
                            .fadeIn(duration: 250.ms)
                            .slideY(begin: 0.05, end: 0, duration: 250.ms),
                        const SizedBox(height: 20),
                        SearchRecentChips(
                          recentSearches: _recentSearches,
                          onSearchSelected: (term) {
                            _searchController.text = term;
                            setState(() => _query = term);
                          },
                        )
                            .animate(delay: 80.ms)
                            .fadeIn(duration: 250.ms)
                            .slideY(begin: 0.05, end: 0, duration: 250.ms),
                      ] else if (results.isEmpty) ...[
                        const SizedBox(height: 20),
                        CuMeoEmptyState(
                          title: 'Không tìm thấy kết quả',
                          subtitle: 'Cú Mèo không tìm thấy đoạn bài giảng nào khớp với "$_query". Bạn hãy thử từ khóa ngắn hơn nhé!',
                          variant: CuMeoVariant.sleeping,
                        )
                            .animate()
                            .fadeIn(duration: 250.ms)
                            .scaleXY(begin: 0.95, end: 1.0, duration: 250.ms),
                      ] else ...[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            'Tìm thấy ${results.length} đoạn trích dẫn bài giảng',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.onSurfaceVariant,
                                ),
                          ),
                        ),
                        ...results.asMap().entries.map(
                          (entry) {
                            final index = entry.key;
                            final res = entry.value;
                            return SearchResultItemWidget(
                              result: res,
                              onTap: () => context.push(
                                '/lecture/${res.lectureId}',
                                extra: {
                                  'initialTabIndex': 0,
                                  'highlightSeconds': res.matchSeconds,
                                  'highlightText': res.snippet,
                                },
                              ),
                            )
                                .animate(delay: (index * 45).clamp(0, 300).ms)
                                .fadeIn(duration: 240.ms, curve: Curves.easeOutCubic)
                                .slideY(begin: 0.05, end: 0, duration: 240.ms, curve: Curves.easeOutCubic);
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
