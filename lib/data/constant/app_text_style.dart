import 'package:flutter/material.dart';

import 'app_color.dart';

extension AppTextStyles on BuildContext {
  bool get _dark => Theme.of(this).brightness == Brightness.dark;

  // ─── Heading ──────────────────────────────────────────────────────
  TextStyle get heading => TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.bold,
    color: _dark ? AppColor.textPrimaryDark : AppColor.textPrimaryLight,
    letterSpacing: -0.3,
    height: 1.2,
  );

  // ─── Title ────────────────────────────────────────────────────────
  TextStyle get title => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: _dark ? AppColor.textPrimaryDark : AppColor.textPrimaryLight,
    letterSpacing: -0.2,
    height: 1.3,
  );

  // ─── Subtitle ─────────────────────────────────────────────────────
  TextStyle get subtitle => TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: _dark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
    letterSpacing: 0,
    height: 1.4,
  );

  // ─── Label ────────────────────────────────────────────────────────
  TextStyle get label => TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: _dark ? AppColor.textPrimaryDark : AppColor.textPrimaryLight,
    letterSpacing: 0,
    height: 1.4,
  );

  // ─── SubLabel ─────────────────────────────────────────────────────
  TextStyle get sublabel => TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: _dark ? AppColor.subLabelDark : AppColor.subLabelLight,
    letterSpacing: 0.1,
    height: 1.5,
  );
}
