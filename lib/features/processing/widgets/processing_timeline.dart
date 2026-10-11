import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

enum StepStatus {
  completed,
  inProgress,
  pending,
}

class ProcessingStepData {
  final String title;
  final String description;
  final StepStatus status;

  const ProcessingStepData({
    required this.title,
    required this.description,
    required this.status,
  });
}

/// Dòng thời gian tiến trình xử lý AI (Vertical Pipeline Timeline)
class ProcessingTimeline extends StatelessWidget {
  final List<ProcessingStepData> steps;

  const ProcessingTimeline({
    super.key,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isLast = index == steps.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column: Dot icon + connecting line
              Column(
                children: [
                  _buildStatusDot(step.status),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: step.status == StepStatus.completed
                            ? AppColors.primaryContainer
                            : AppColors.outline,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              // Right Column: Title + Description
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: step.status == StepStatus.pending
                                  ? AppColors.onSurfaceVariant
                                  : AppColors.onSurface,
                            ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        step.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatusDot(StepStatus status) {
    switch (status) {
      case StepStatus.completed:
        return Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            color: AppColors.mintGreenDark,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, size: 14, color: Colors.white),
        );
      case StepStatus.inProgress:
        return Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            color: AppColors.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        );
      case StepStatus.pending:
        return Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.outlineVariant, width: 1.5),
          ),
        );
    }
  }
}
