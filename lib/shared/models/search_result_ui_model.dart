/// Model kết quả tìm kiếm toàn cục
class SearchResultUiModel {
  final String lectureId;
  final String lectureTitle;
  final String subject;
  final String snippet;
  final String matchTimestamp;
  final int matchSeconds;

  const SearchResultUiModel({
    required this.lectureId,
    required this.lectureTitle,
    required this.subject,
    required this.snippet,
    required this.matchTimestamp,
    required this.matchSeconds,
  });

  static List<SearchResultUiModel> mockResults = [
    const SearchResultUiModel(
      lectureId: 'lec_1',
      lectureTitle: 'Lập trình Web - Bài 5: REST API & JWT Authentication',
      subject: 'Công nghệ phần mềm',
      snippet: '“...Bearer Token chứa payload được mã hóa Base64 và ký bí mật bằng khóa HMAC-SHA256...”',
      matchTimestamp: '12:35',
      matchSeconds: 755,
    ),
    const SearchResultUiModel(
      lectureId: 'lec_1',
      lectureTitle: 'Lập trình Web - Bài 5: REST API & JWT Authentication',
      subject: 'Công nghệ phần mềm',
      snippet: '“...không bao giờ lưu mật khẩu thuần bên trong payload của JWT vì Base64 dễ bị giải mã...”',
      matchTimestamp: '20:15',
      matchSeconds: 1215,
    ),
    const SearchResultUiModel(
      lectureId: 'lec_3',
      lectureTitle: 'Xác suất thống kê - Phân phối chuẩn',
      subject: 'Toán ứng dụng',
      snippet: '“...Quy tắc kiểm định P-Value < 0.05 bác bỏ giả thuyết H0...”',
      matchTimestamp: '34:10',
      matchSeconds: 2050,
    ),
  ];
}
