import 'package:flutter/material.dart';
import '../../../../shared/widgets/inputs/ll_text_field.dart';

/// Form thông tin bài giảng khi upload
class UploadMetadataForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController subjectController;
  final TextEditingController universityController;
  final TextEditingController noteController;

  const UploadMetadataForm({
    super.key,
    required this.titleController,
    required this.subjectController,
    required this.universityController,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LlTextField(
          controller: titleController,
          label: 'Tên bài giảng',
          hintText: 'VD: Lập trình Web - Buổi 6: GraphQL & Caching',
          prefixIcon: const Icon(Icons.school_outlined, size: 20),
        ),
        const SizedBox(height: 14),
        LlTextField(
          controller: subjectController,
          label: 'Môn học',
          hintText: 'VD: Công nghệ phần mềm',
          prefixIcon: const Icon(Icons.menu_book_outlined, size: 20),
        ),
        const SizedBox(height: 14),
        LlTextField(
          controller: universityController,
          label: 'Giảng viên / Trường',
          hintText: 'VD: TS. Nguyễn Văn B • ĐH Bách Khoa',
          prefixIcon: const Icon(Icons.account_balance_outlined, size: 20),
        ),
        const SizedBox(height: 14),
        LlTextField(
          controller: noteController,
          label: 'Ghi chú cho Cú Mèo AI (Tùy chọn)',
          hintText: 'VD: Tập trung tóm tắt phần công thức thi giữa kỳ...',
          maxLines: 3,
        ),
      ],
    );
  }
}
