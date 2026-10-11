enum LectureStatus {
  ready,
  processing,
  error,
}

class LectureTopicItem {
  final String title;
  final String timestamp;
  final int startSeconds;
  final bool isCompleted;

  const LectureTopicItem({
    required this.title,
    required this.timestamp,
    required this.startSeconds,
    this.isCompleted = false,
  });
}

class TranscriptSegment {
  final String timestamp;
  final int startSeconds;
  final String speaker;
  final String content;
  final bool isKeyPoint;
  final String? stickyNoteText;

  const TranscriptSegment({
    required this.timestamp,
    required this.startSeconds,
    required this.speaker,
    required this.content,
    this.isKeyPoint = false,
    this.stickyNoteText,
  });
}

class AiChatMessage {
  final String id;
  final String sender; // 'user' | 'cu_meo'
  final String content;
  final String timestamp;
  final String? citationTime;
  final int? citationSeconds;

  const AiChatMessage({
    required this.id,
    required this.sender,
    required this.content,
    required this.timestamp,
    this.citationTime,
    this.citationSeconds,
  });
}

/// !IMPORTANT: Model dữ liệu hiển thị giao diện bài giảng (Mock UI Model)
/// CHỈ DẪN: Cầu nối trực tiếp để tích hợp REST API sau này mà không cần sửa cấu trúc UI.
class LectureUiModel {
  final String id;
  final String title;
  final String subject;
  final String university;
  final LectureStatus status;
  final double processingProgress; // 0.0 to 1.0
  final String? processingStatusText;
  final String? remainingTimeText;
  final String? audioFileName;
  final String? audioFileSize;
  final int durationSeconds;
  final int topicsCount;
  final String? stickySnippet;
  final String relativeTime;
  final int? resumePositionSeconds;
  final List<String> tags;
  final bool isBookmarked;
  final List<LectureTopicItem> topics;
  final List<TranscriptSegment> transcripts;
  final List<AiChatMessage> aiMessages;

  const LectureUiModel({
    required this.id,
    required this.title,
    required this.subject,
    this.university = 'ĐH Bách Khoa',
    required this.status,
    this.processingProgress = 0.0,
    this.processingStatusText,
    this.remainingTimeText,
    this.audioFileName,
    this.audioFileSize,
    this.durationSeconds = 0,
    this.topicsCount = 0,
    this.stickySnippet,
    required this.relativeTime,
    this.resumePositionSeconds,
    this.tags = const [],
    this.isBookmarked = false,
    this.topics = const [],
    this.transcripts = const [],
    this.aiMessages = const [],
  });

  /// Mock data phản ánh chính xác 100% các file thiết kế
  static List<LectureUiModel> mockLectures = [
    LectureUiModel(
      id: 'lec_1',
      title: 'Lập trình Web - Bài 5: REST API & JWT Authentication',
      subject: 'Công nghệ phần mềm',
      university: 'ĐH Bách Khoa',
      status: LectureStatus.ready,
      durationSeconds: 2720, // 45:20
      topicsCount: 4,
      stickySnippet: 'Bearer Token chứa payload được mã hóa Base64 và ký bí mật bằng khóa HMAC-SHA256.',
      relativeTime: 'Hôm qua 14:30',
      resumePositionSeconds: 755, // 12:35
      isBookmarked: true,
      tags: ['# REST API', '# JWT', '# Security', '# HTTP'],
      topics: const [
        LectureTopicItem(title: '1. Khái quát kiến trúc RESTful Services', timestamp: '00:00', startSeconds: 0, isCompleted: true),
        LectureTopicItem(title: '2. Cấu trúc Token JWT & Header Payload Signature', timestamp: '12:35', startSeconds: 755, isCompleted: false),
        LectureTopicItem(title: '3. Middleware xác thực trong Express/Spring', timestamp: '24:10', startSeconds: 1450, isCompleted: false),
        LectureTopicItem(title: '4. Best practices bảo mật Refresh Token', timestamp: '37:45', startSeconds: 2265, isCompleted: false),
      ],
      transcripts: const [
        TranscriptSegment(
          timestamp: '00:05',
          startSeconds: 5,
          speaker: 'Giảng viên',
          content: 'Chào các em! Hôm nay chúng ta đi sâu vào chuẩn thiết kế REST API và cơ chế chứng thực bằng JSON Web Token (JWT).',
        ),
        TranscriptSegment(
          timestamp: '12:35',
          startSeconds: 755,
          speaker: 'Giảng viên',
          content: 'Bearer Token chứa payload được mã hóa Base64 và ký bí mật bằng khóa HMAC-SHA256. Phía Client lưu trữ token này và gửi kèm trong Authorization Header ở mỗi Request.',
          isKeyPoint: true,
          stickyNoteText: 'Trọng tâm ôn thi: Phân biệt sự khác nhau giữa Access Token (ngắn hạn) và Refresh Token (dài hạn).',
        ),
        TranscriptSegment(
          timestamp: '20:15',
          startSeconds: 1215,
          speaker: 'Giảng viên',
          content: 'Các bạn lưu ý không bao giờ lưu trữ mật khẩu thuần hoặc thông tin bảo mật tuyệt mật bên trong payload của JWT vì Base64 rất dễ bị giải mã.',
        ),
      ],
      aiMessages: const [
        AiChatMessage(
          id: 'msg_1',
          sender: 'user',
          content: 'Thầy nhấn mạnh điểm nào nhất về JWT vậy Cú Mèo?',
          timestamp: '14:32',
        ),
        AiChatMessage(
          id: 'msg_2',
          sender: 'cu_meo',
          content: 'Thầy nhấn mạnh tại phút 12:35 rằng: Payload của JWT chỉ được mã hóa Base64 chứ không hề bảo mật, vì vậy tuyệt đối không để mật khẩu bên trong! Thay vào đó phải xác thực chữ ký (Signature) bằng Secret Key.',
          timestamp: '14:33',
          citationTime: '12:35',
          citationSeconds: 755,
        ),
      ],
    ),
    LectureUiModel(
      id: 'lec_2',
      title: 'Kiến trúc máy tính - Chương 3: Pipeline & Bộ nhớ đệm',
      subject: 'Khoa học máy tính',
      university: 'ĐH Bách Khoa',
      status: LectureStatus.processing,
      processingProgress: 0.68,
      processingStatusText: 'Đang tách chủ đề & lập mục lục thông minh...',
      remainingTimeText: '~ 45 giây nữa',
      audioFileName: 'Bản ghi phòng học H1-302 (58.4 MB)',
      audioFileSize: '58.4 MB',
      relativeTime: 'Vừa xong',
      tags: ['# Pipeline', '# Cache L1/L2', '# Hazard'],
    ),
    LectureUiModel(
      id: 'lec_3',
      title: 'Xác suất thống kê - Phân phối chuẩn & Kiểm định giả thuyết',
      subject: 'Toán ứng dụng',
      university: 'ĐH Khoa Học Tự Nhiên',
      status: LectureStatus.ready,
      durationSeconds: 3130, // 52:10
      topicsCount: 6,
      relativeTime: '2 ngày trước',
      tags: ['# Z-Score', '# P-Value < 0.05', '# Định lý giới hạn trung tâm'],
      topics: const [
        LectureTopicItem(title: '1. Khái niệm biến ngẫu nhiên liên tục', timestamp: '00:00', startSeconds: 0, isCompleted: true),
        LectureTopicItem(title: '2. Đường cong phân phối hình chuông Gauss', timestamp: '15:20', startSeconds: 920, isCompleted: true),
        LectureTopicItem(title: '3. Quy tắc kiểm định P-Value < 0.05', timestamp: '34:10', startSeconds: 2050, isCompleted: false),
      ],
      transcripts: const [
        TranscriptSegment(
          timestamp: '00:00',
          startSeconds: 0,
          speaker: 'Giảng viên',
          content: 'Chúng ta bắt đầu ôn lại biến ngẫu nhiên liên tục và hàm mật độ xác suất.',
        ),
        TranscriptSegment(
          timestamp: '15:20',
          startSeconds: 920,
          speaker: 'Giảng viên',
          content: 'Phân phối chuẩn có dạng chuông đối xứng qua giá trị kỳ vọng Muy.',
          isKeyPoint: true,
          stickyNoteText: 'Công thức tính Z-Score chuẩn hóa: Z = (X - μ) / σ',
        ),
      ],
    ),
  ];
}
