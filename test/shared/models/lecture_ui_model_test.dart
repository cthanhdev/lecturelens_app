import 'package:flutter_test/flutter_test.dart';
import 'package:lecturelens_app/shared/models/lecture_ui_model.dart';

void main() {
  group('LectureUiModel Tests', () {
    test('mockLectures contains predefined sample data with valid statuses', () {
      expect(LectureUiModel.mockLectures, isNotEmpty);
      expect(LectureUiModel.mockLectures.length, 3);

      final first = LectureUiModel.mockLectures.first;
      expect(first.id, 'lec_1');
      expect(first.status, LectureStatus.ready);
      expect(first.durationSeconds, greaterThan(0));
      expect(first.topics, isNotEmpty);
      expect(first.transcripts, isNotEmpty);
      expect(first.aiMessages, isNotEmpty);

      final second = LectureUiModel.mockLectures[1];
      expect(second.id, 'lec_2');
      expect(second.status, LectureStatus.processing);
      expect(second.processingProgress, inInclusiveRange(0.0, 1.0));
    });

    test('LectureTopicItem and TranscriptSegment model instantiations', () {
      const topic = LectureTopicItem(
        title: 'Giới thiệu',
        timestamp: '01:00',
        startSeconds: 60,
        isCompleted: true,
      );
      expect(topic.title, 'Giới thiệu');
      expect(topic.isCompleted, isTrue);

      const segment = TranscriptSegment(
        timestamp: '01:00',
        startSeconds: 60,
        speaker: 'Giảng viên',
        content: 'Nội dung mẫu',
        isKeyPoint: true,
        stickyNoteText: 'Ghi nhớ trọng tâm',
      );
      expect(segment.isKeyPoint, isTrue);
      expect(segment.stickyNoteText, 'Ghi nhớ trọng tâm');
    });
  });
}
