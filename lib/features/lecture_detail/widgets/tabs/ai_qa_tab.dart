import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/asset_paths.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/lecture_ui_model.dart';
import '../ai_chat_bubble.dart';

/// !IMPORTANT: Tab Hỏi Đáp AI Cú Mèo (AI Q&A Tab)
/// CHỈ DẪN: Sử dụng ListView(reverse: true) để tin nhắn mới nhất hiển thị ở dưới cùng
/// và đẩy các tin cũ lên trên. Danh sách tin nhắn đảo ngược thứ tự để thêm mới vào index 0.
class AiQaTab extends StatefulWidget {
  final List<AiChatMessage> initialMessages;
  final ValueChanged<int>? onSeekSeconds;

  const AiQaTab({
    super.key,
    required this.initialMessages,
    this.onSeekSeconds,
  });

  @override
  State<AiQaTab> createState() => _AiQaTabState();
}

class _AiQaTabState extends State<AiQaTab> {
  late List<AiChatMessage> _reversedMessages;
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Đảo ngược danh sách cho ListView(reverse: true)
    _reversedMessages = List.from(widget.initialMessages.reversed);
  }

  void _sendMessage([String? presetText]) {
    final text = presetText ?? _inputController.text.trim();
    if (text.isEmpty) return;

    final userMsg = AiChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: 'user',
      content: text,
      timestamp: 'Vừa xong',
    );

    setState(() {
      _reversedMessages.insert(0, userMsg);
      if (presetText == null) {
        _inputController.clear();
      }
    });

    // Mock phản hồi từ Cú Mèo AI sau 800ms
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      final aiResponse = AiChatMessage(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        sender: 'cu_meo',
        content: 'Theo bài giảng, Bearer Token được ký HMAC-SHA256 để đảm bảo tính toàn vẹn dữ liệu. Bạn nên chú ý phần phân biệt Access Token và Refresh Token nhé!',
        timestamp: 'Vừa xong',
        citationTime: '12:35',
        citationSeconds: 755,
      );
      setState(() {
        _reversedMessages.insert(0, aiResponse);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Quick suggestion chips
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildSuggestionChip('✨ Tóm tắt 3 ý chính'),
              _buildSuggestionChip('📌 Trọng tâm ôn thi'),
              _buildSuggestionChip('💡 Giải thích Base64 JWT'),
            ],
          ),
        ),

        // Chat Message List (reverse: true)
        Expanded(
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: _reversedMessages.length,
            itemBuilder: (context, index) {
              final msg = _reversedMessages[index];
              return AiChatBubble(
                message: msg,
                onCitationTap: () {
                  if (msg.citationSeconds != null) {
                    widget.onSeekSeconds?.call(msg.citationSeconds!);
                  }
                },
              );
            },
          ),
        ),

        // Bottom Input Bar
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          decoration: BoxDecoration(
            color: AppColors.canvasCream,
            border: Border(top: BorderSide(color: AppColors.outline.withOpacity(0.8))),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 46,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceCard,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppColors.outline),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _inputController,
                          onSubmitted: (_) => _sendMessage(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: const InputDecoration(
                            hintText: 'Hỏi Cú Mèo về bài giảng...',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        AssetPaths.icMic,
                        width: 16,
                        height: 16,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryContainer,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Send Button
              GestureDetector(
                onTap: () => _sendMessage(),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryContainer,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AssetPaths.icSend,
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionChip(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(
          text,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: AppColors.surfaceCard,
        side: const BorderSide(color: AppColors.outline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        onPressed: () => _sendMessage(text),
      ),
    );
  }
}
