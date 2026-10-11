import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import 'audio_progress_bar.dart';
import 'audio_waveform.dart';

/// !IMPORTANT: Floating Frosted Glass Audio Capsule (Viên nhộng phát âm thanh)
/// CHỈ DẪN: Thanh phát âm thanh kính mờ (BackdropFilter 16dp blur)
/// Tích hợp đầy đủ nút Play/Pause, Tua 10s trước/sau, Tốc độ 1.0x/1.2x/1.5x và waveform
class AudioPlayerCapsule extends StatefulWidget {
  final String title;
  final String subtitle;
  final Duration totalDuration;
  final Duration initialPosition;
  final ValueChanged<bool>? onPlayStateChanged;

  const AudioPlayerCapsule({
    super.key,
    required this.title,
    this.subtitle = 'Bản ghi phòng học • H1-302',
    this.totalDuration = const Duration(minutes: 45, seconds: 20),
    this.initialPosition = const Duration(minutes: 12, seconds: 35),
    this.onPlayStateChanged,
  });

  @override
  State<AudioPlayerCapsule> createState() => _AudioPlayerCapsuleState();
}

class _AudioPlayerCapsuleState extends State<AudioPlayerCapsule> {
  bool _isPlaying = false;
  late Duration _currentPosition;
  double _playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.initialPosition;
  }

  void _togglePlay() {
    setState(() => _isPlaying = !_isPlaying);
    widget.onPlayStateChanged?.call(_isPlaying);
  }

  void _rewind10s() {
    setState(() {
      final newSec = (_currentPosition.inSeconds - 10).clamp(0, widget.totalDuration.inSeconds);
      _currentPosition = Duration(seconds: newSec);
    });
  }

  void _forward10s() {
    setState(() {
      final newSec = (_currentPosition.inSeconds + 10).clamp(0, widget.totalDuration.inSeconds);
      _currentPosition = Duration(seconds: newSec);
    });
  }

  void _cycleSpeed() {
    setState(() {
      if (_playbackSpeed == 1.0) {
        _playbackSpeed = 1.25;
      } else if (_playbackSpeed == 1.25) {
        _playbackSpeed = 1.5;
      } else {
        _playbackSpeed = 1.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceCard.withOpacity(0.92),
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.level2,
        border: Border.all(
          color: AppColors.outline.withOpacity(0.7),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top row: Title + Speed Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.onSurface,
                                ),
                          ),
                          Text(
                            widget.subtitle,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 11,
                                ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _cycleSpeed,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '${_playbackSpeed}x',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Waveform indicator
                AudioWaveform(
                  isPlaying: _isPlaying,
                  height: 24,
                  barCount: 32,
                ),
                const SizedBox(height: 6),
                // Progress Bar Scrubber
                AudioProgressBar(
                  currentPosition: _currentPosition,
                  totalDuration: widget.totalDuration,
                  onSeek: (newPos) => setState(() => _currentPosition = newPos),
                ),
                const SizedBox(height: 8),
                // Controls Row: Rewind 10s, Play/Pause, Forward 10s
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _rewind10s,
                      icon: SvgPicture.asset(
                        AssetPaths.icRewind,
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          AppColors.onSurfaceVariant,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: _togglePlay,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.primaryContainer,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryContainer.withOpacity(0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            _isPlaying ? AssetPaths.icPause : AssetPaths.icPlay,
                            width: 18,
                            height: 18,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: _forward10s,
                      icon: SvgPicture.asset(
                        AssetPaths.icForward,
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          AppColors.onSurfaceVariant,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
