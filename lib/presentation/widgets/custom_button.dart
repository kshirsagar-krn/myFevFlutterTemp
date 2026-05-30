import 'package:flutter/material.dart';
import '../../data/constant/app_color.dart';

enum CustomButtonStyle { fill, outline, text }

class CustomButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback onTap;
  final bool isLoading;
  final bool isEnabled;

  // Style properties
  final CustomButtonStyle style;
  final Color? backgroundColor;
  final Gradient? gradient; // Added optional gradient
  final Color? textColor;
  final Color? borderColor;

  // Disabled state colors
  final Color disabledBackgroundColor;
  final Color disabledTextColor;
  final Color disabledBorderColor;

  final double height;
  final double borderRadius;
  final double borderWidth;
  final Widget? loadingWidget;

  const CustomButton({
    super.key,
    this.text,
    this.child,
    required this.onTap,
    this.isLoading = false,
    this.isEnabled = true,
    this.style = CustomButtonStyle.fill,
    this.backgroundColor,
    this.gradient, // Added to constructor
    this.textColor,
    this.borderColor,
    this.disabledBackgroundColor = const Color(0xFFE2E8F0),
    this.disabledTextColor = const Color(0xFF94A3B8),
    this.disabledBorderColor = const Color(0xFFE2E8F0),
    this.height = 52,
    this.borderRadius = 8,
    this.borderWidth = 1.5,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    final bool canTap = isEnabled && !isLoading;

    // Resolve colors based on current style and state
    Color? effectiveBgColor;
    Color effectiveTextColor;
    Color effectiveBorderColor;
    Gradient? effectiveGradient;

    switch (style) {
      case CustomButtonStyle.fill:
        effectiveBgColor = canTap
            ? (backgroundColor ?? AppColor.primaryColor)
            : disabledBackgroundColor;
        effectiveTextColor = canTap
            ? (textColor ?? Colors.white)
            : disabledTextColor;
        effectiveBorderColor = Colors.transparent;
        // Only apply the gradient if the button is enabled and active
        effectiveGradient = canTap ? gradient : null;
        break;

      case CustomButtonStyle.outline:
        effectiveBgColor = Colors.transparent;
        effectiveTextColor = canTap
            ? (textColor ?? AppColor.primaryColor)
            : disabledTextColor;
        effectiveBorderColor = canTap
            ? (borderColor ?? AppColor.primaryColor)
            : disabledBorderColor;
        effectiveGradient = null;
        break;

      case CustomButtonStyle.text:
        effectiveBgColor = Colors.transparent;
        effectiveTextColor = canTap
            ? (textColor ?? AppColor.primaryColor)
            : disabledTextColor;
        effectiveBorderColor = Colors.transparent;
        effectiveGradient = null;
        break;
    }

    return GestureDetector(
      onTap: canTap ? onTap : null,
      child: Opacity(
        // Subtle feedback for disabled state
        opacity: canTap ? 1.0 : 0.7,
        child: Container(
          height: height,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            // If a gradient is active, color must be null to avoid conflicts in BoxDecoration
            color: effectiveGradient == null ? effectiveBgColor : null,
            gradient: effectiveGradient,
            borderRadius: BorderRadius.circular(borderRadius),
            border: style == CustomButtonStyle.outline
                ? Border.all(color: effectiveBorderColor, width: borderWidth)
                : null,
          ),
          child: isLoading
              ? (loadingWidget ?? _buildDefaultLoading(effectiveTextColor))
              : (child ??
                    Text(
                      text ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: effectiveTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
        ),
      ),
    );
  }

  Widget _buildDefaultLoading(Color color) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
