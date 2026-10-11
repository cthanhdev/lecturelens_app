import 'package:flutter/material.dart';

/// Hằng số bo góc tròn thân thiện (Pill & Rounded shapes)
class AppBorderRadius {
  AppBorderRadius._();

  static const double card = 24.0;
  static const double modal = 28.0;
  static const double input = 20.0;
  static const double stickyNote = 18.0;
  static const double button = 999.0;
  static const double chip = 999.0;
  static const double pill = 999.0;

  static final BorderRadius cardRadius = BorderRadius.circular(card);
  static final BorderRadius modalRadius = BorderRadius.circular(modal);
  static final BorderRadius inputRadius = BorderRadius.circular(input);
  static final BorderRadius stickyNoteRadius = BorderRadius.circular(stickyNote);
  static final BorderRadius pillRadius = BorderRadius.circular(pill);
}
