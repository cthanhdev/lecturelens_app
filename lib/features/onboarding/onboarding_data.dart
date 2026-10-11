import '../../core/constants/asset_paths.dart';

class OnboardingSlideData {
  final String title;
  final String description;
  final String imagePath;
  final String tag;

  const OnboardingSlideData({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.tag,
  });

  static const List<OnboardingSlideData> slides = [
    OnboardingSlideData(
      title: 'Tự động hóa giảng đường 🎒',
      description: 'Ghi âm hoặc tải file bài giảng lên. Cú Mèo AI sẽ tự động phân loại chủ đề và lập mục lục thông minh cho bạn.',
      imagePath: AssetPaths.cuMeoHappy,
      tag: 'Học tập thông minh',
    ),
    OnboardingSlideData(
      title: 'Nhận diện giọng nói chuẩn xác 🎧',
      description: 'Chuyển bài giảng thành văn bản tiếng Việt đầy đủ dấu câu, kèm mốc thời gian chuẩn xác đến từng giây.',
      imagePath: AssetPaths.cuMeoListening,
      tag: 'Bản ghi thông minh',
    ),
    OnboardingSlideData(
      title: 'Hỏi đáp AI & Trích dẫn tức thì ✨',
      description: 'Thắc mắc công thức hay lý thuyết? Cú Mèo sẽ giải đáp ngay lập tức kèm trích dẫn chính xác vị trí thầy cô giảng.',
      imagePath: AssetPaths.logoSplash,
      tag: 'Trợ thủ đắc lực',
    ),
  ];
}
