import 'package:flutter_test/flutter_test.dart';
import 'package:lecturelens_app/shared/models/search_result_ui_model.dart';

void main() {
  group('SearchResultUiModel Tests', () {
    test('mockResults contains valid search results with snippet and timestamps', () {
      expect(SearchResultUiModel.mockResults, isNotEmpty);
      expect(SearchResultUiModel.mockResults.length, 3);

      final first = SearchResultUiModel.mockResults.first;
      expect(first.lectureId, 'lec_1');
      expect(first.lectureTitle, isNotEmpty);
      expect(first.subject, isNotEmpty);
      expect(first.snippet, contains('Bearer Token'));
      expect(first.matchTimestamp, '12:35');
      expect(first.matchSeconds, 755);
    });

    test('SearchResultUiModel constructor sets all fields accurately', () {
      const result = SearchResultUiModel(
        lectureId: 'lec_10',
        lectureTitle: 'Lý thuyết Đồ thị',
        subject: 'Cấu trúc dữ liệu',
        snippet: 'Thuật toán Dijkstra tìm đường đi ngắn nhất',
        matchTimestamp: '08:45',
        matchSeconds: 525,
      );

      expect(result.lectureId, 'lec_10');
      expect(result.lectureTitle, 'Lý thuyết Đồ thị');
      expect(result.subject, 'Cấu trúc dữ liệu');
      expect(result.snippet, contains('Dijkstra'));
      expect(result.matchTimestamp, '08:45');
      expect(result.matchSeconds, 525);
    });
  });
}
