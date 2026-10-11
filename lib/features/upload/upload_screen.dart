import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/buttons/ll_primary_button.dart';
import '../../shared/widgets/dot_background.dart';
import '../../shared/widgets/ll_app_bar.dart';
import 'widgets/upload_drop_zone.dart';
import 'widgets/upload_metadata_form.dart';

/// !IMPORTANT: Màn Hình Tải Bản Ghi Lên (Upload Screen)
/// CHỈ DẪN: Cho phép sinh viên tải tệp âm thanh ghi âm bài giảng lên
/// để gửi tới AI pipeline xử lý (chuyển sang processing_screen).
class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? _fileName = 'Record_Web_Lecture_B6.m4a';
  String? _fileSize = '42.8 MB • 52:14 phút';
  final _titleController = TextEditingController(text: 'Lập trình Web - Buổi 6: Kiến trúc Microservices');
  final _subjectController = TextEditingController(text: 'Công nghệ phần mềm');
  final _universityController = TextEditingController(text: 'ĐH Bách Khoa');
  final _noteController = TextEditingController();

  void _pickMockFile() {
    setState(() {
      _fileName = 'GhiAm_KienTrucMayTinh_Ch4.mp3';
      _fileSize = '61.2 MB • 1:12:05 giờ';
    });
  }

  void _handleStartProcessing() {
    context.push(AppConstants.routeProcessing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasCream,
      appBar: LlAppBar(
        title: 'Tải bản ghi lên',
        subtitle: 'Bàn học của bạn',
        showBack: true,
        showNotifications: false,
      ),
      body: DotBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Drop zone
                UploadDropZone(
                  selectedFileName: _fileName,
                  selectedFileSize: _fileSize,
                  onTap: _pickMockFile,
                  onClear: () => setState(() {
                    _fileName = null;
                    _fileSize = null;
                  }),
                ),
                const SizedBox(height: 20),

                // Form Container Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceCard,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.outline),
                  ),
                  child: UploadMetadataForm(
                    titleController: _titleController,
                    subjectController: _subjectController,
                    universityController: _universityController,
                    noteController: _noteController,
                  ),
                ),
                const SizedBox(height: 24),

                // Primary Start Processing Button
                LlPrimaryButton(
                  text: 'Bắt đầu xử lý với Cú Mèo AI 🚀',
                  onPressed: _fileName != null ? _handleStartProcessing : null,
                  icon: const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
