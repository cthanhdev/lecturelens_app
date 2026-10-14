import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_shadows.dart';
import '../../shared/widgets/buttons/ll_primary_button.dart';
import '../../shared/widgets/dot_background.dart';
import '../../shared/widgets/ll_app_bar.dart';
import '../../shared/widgets/mascot/cu_meo_widget.dart';
import 'widgets/processing_timeline.dart';

/// !IMPORTANT: Màn Hình Đang Xử Lý Bài Giảng (Processing Screen)
/// CHỈ DẪN: Hiển thị thanh tiến trình 68%, linh vật Cú Mèo lắng nghe,
/// và từng bước trong pipeline AI Whisper & LLM tóm tắt.
class ProcessingScreen extends StatefulWidget {
  final String? lectureTitle;
  final String? lectureSubject;

  const ProcessingScreen({
    super.key,
    this.lectureTitle,
    this.lectureSubject,
  });

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen>
    with SingleTickerProviderStateMixin {
  static const double _targetProgress = 0.68;
  late final AnimationController _progressController;
  late final Animation<double> _progressAnimation;

  final List<ProcessingStepData> _steps = const [
    ProcessingStepData(
      title: '1. Khử tạp âm & Chuẩn hóa âm thanh',
      description: 'Loại bỏ tiếng ồn giảng đường, tăng độ nét giọng giảng viên.',
      status: StepStatus.completed,
    ),
    ProcessingStepData(
      title: '2. Nhận diện giọng nói tiếng Việt (Whisper AI)',
      description: 'Chuyển hóa 52 phút bài giảng thành văn bản có dấu.',
      status: StepStatus.completed,
    ),
    ProcessingStepData(
      title: '3. Phân đoạn chủ đề & Lập mục lục thông minh',
      description: 'Đang trích xuất 4 chủ đề chính và gắn mốc thời gian...',
      status: StepStatus.inProgress,
    ),
    ProcessingStepData(
      title: '4. Trích xuất trọng tâm ôn thi & Tạo trợ thủ Q&A',
      description: 'Tổng hợp các công thức cốt lõi và thẻ Sticky Notes.',
      status: StepStatus.pending,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeOutCubic,
    );
    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const LlAppBar(
        title: 'Tiến trình bài giảng',
        subtitle: 'Cú Mèo đang lắng nghe',
        showBack: true,
        showNotifications: false,
      ),
      body: DotBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                // Top Mascot & Progress Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceCard,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: AppShadows.level1,
                  ),
                  child: Column(
                    children: [
                      const CuMeoWidget(
                        variant: CuMeoVariant.listening,
                        size: 110,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Đang xử lý bài giảng...',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.onSurface,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.lectureTitle ?? 'Kiến trúc máy tính - Chương 3: Pipeline',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (widget.lectureSubject != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          widget.lectureSubject!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.onSurfaceVariant,
                                fontSize: 11,
                              ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      // Animated Progress Bar & Percentage
                      AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, _) {
                          final currentProgress = _targetProgress * _progressAnimation.value;
                          final percent = (currentProgress * 100).toInt();

                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tiến độ xử lý',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          color: AppColors.onSurfaceVariant,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  Text(
                                    '$percent%',
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          color: AppColors.primaryContainer,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceContainer,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(999),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: currentProgress,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.primary,
                                            AppColors.primaryContainer,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ước tính còn lại',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
                          ),
                          Text(
                            '~ 45 giây nữa',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: AppColors.primary,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Vertical Pipeline Steps Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceCard,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppShadows.level1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Các bước xử lý bài giảng',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.onSurface,
                            ),
                      ),
                      const SizedBox(height: 16),
                      ProcessingTimeline(steps: _steps),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Actions
                LlPrimaryButton(
                  text: 'Xem bản mẫu sẵn sàng (Demo) →',
                  onPressed: () => context.go('/lecture/lec_1'),
                  icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => context.go(AppConstants.routeLibrary),
                  child: Text(
                    'Để Cú Mèo chạy nền và quay về Thư viện',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.onSurfaceVariant,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
