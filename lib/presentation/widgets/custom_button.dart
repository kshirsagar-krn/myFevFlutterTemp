import 'package:flutter/material.dart';
import '../../data/constant/app_color.dart';

enum CustomButtonStyle { fill, outline, text }

class CustomButton extends StatefulWidget {
  final String? text;
  final Widget? child;
  final VoidCallback onTap;
  final bool isLoading;
  final bool isEnabled;

  // Style properties
  final CustomButtonStyle style;
  final Color? backgroundColor;
  final Gradient? gradient; 
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
    this.gradient, 
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
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.96, // Scale down to 96%
      upperBound: 1.0,
    )..value = 1.0;

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.isEnabled && !widget.isLoading) {
      _animationController.reverse(); // Scale down
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.isEnabled && !widget.isLoading) {
      _animationController.forward(); // Scale up
    }
  }

  void _onTapCancel() {
    if (widget.isEnabled && !widget.isLoading) {
      _animationController.forward(); // Scale up
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canTap = widget.isEnabled && !widget.isLoading;

    // Resolve colors based on current style and state
    Color? effectiveBgColor;
    Color effectiveTextColor;
    Color effectiveBorderColor;
    Gradient? effectiveGradient;

    switch (widget.style) {
      case CustomButtonStyle.fill:
        effectiveBgColor = canTap
            ? (widget.backgroundColor ?? AppColor.primaryColor)
            : widget.disabledBackgroundColor;
        effectiveTextColor = canTap
            ? (widget.textColor ?? Colors.white)
            : widget.disabledTextColor;
        effectiveBorderColor = Colors.transparent;
        effectiveGradient = canTap ? widget.gradient : null;
        break;

      case CustomButtonStyle.outline:
        effectiveBgColor = Colors.transparent;
        effectiveTextColor = canTap
            ? (widget.textColor ?? AppColor.primaryColor)
            : widget.disabledTextColor;
        effectiveBorderColor = canTap
            ? (widget.borderColor ?? AppColor.primaryColor)
            : widget.disabledBorderColor;
        effectiveGradient = null;
        break;

      case CustomButtonStyle.text:
        effectiveBgColor = Colors.transparent;
        effectiveTextColor = canTap
            ? (widget.textColor ?? AppColor.primaryColor)
            : widget.disabledTextColor;
        effectiveBorderColor = Colors.transparent;
        effectiveGradient = null;
        break;
    }

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: canTap ? widget.onTap : null,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: canTap ? 1.0 : 0.6,
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: effectiveGradient == null ? effectiveBgColor : null,
              gradient: effectiveGradient,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: widget.style == CustomButtonStyle.outline
                  ? Border.all(color: effectiveBorderColor, width: widget.borderWidth)
                  : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: canTap ? widget.onTap : null,
                splashColor: effectiveTextColor.withOpacity(0.12),
                highlightColor: effectiveTextColor.withOpacity(0.06),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: widget.isLoading
                      ? (widget.loadingWidget ?? _buildDefaultLoading(effectiveTextColor))
                      : (widget.child ??
                            Text(
                              widget.text ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: effectiveTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                ),
              ),
            ),
          ),
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
