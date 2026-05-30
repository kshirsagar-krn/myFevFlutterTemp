// ignore_for_file: deprecated_member_use
import 'package:myFevTempV1/data/constant/app_color.dart';
import 'package:flutter/material.dart';

class CustomDecoration {
  static InputDecoration input({
    required BuildContext context,
    required String hintText,
    TextStyle? hintStyle,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? fillColor,
    double borderRadius = 10,
  }) {
    return InputDecoration(
      isCollapsed: true,
      filled: true,
      // Uses the provided color or falls back to your context extension
      fillColor: fillColor ?? context.lightCardColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      // Default Border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      // Focused Border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: context.textPrimaryColor, width: 1.4),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      // Error Border
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      hintText: hintText,
      hintStyle:
          hintStyle ??
          TextStyle(
            color: Theme.of(context).hintColor.withOpacity(0.4),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
}
