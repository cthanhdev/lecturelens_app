import 'package:flutter/material.dart';
import '../../../../shared/models/lecture_ui_model.dart';
import '../transcript_segment.dart';

/// Tab Bản Ghi Chi Tiết Bài Giảng
class TranscriptTab extends StatelessWidget {
  final List<TranscriptSegment> segments;
  final ValueChanged<int>? onSeekSeconds;

  const TranscriptTab({
    super.key,
    required this.segments,
    this.onSeekSeconds,
  });

  @override
  Widget build(BuildContext context) {
    if (segments.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text('Chưa có nội dung bản ghi âm.'),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
      itemCount: segments.length,
      itemBuilder: (context, index) {
        final segment = segments[index];
        return TranscriptSegmentWidget(
          segment: segment,
          onSeek: () => onSeekSeconds?.call(segment.startSeconds),
        );
      },
    );
  }
}
