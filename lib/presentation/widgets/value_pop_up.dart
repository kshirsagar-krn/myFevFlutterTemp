import 'package:flutter/material.dart';

class ValuePopUp extends StatefulWidget {
  final int beginValue;
  final int endValue;
  final Duration duration;
  final TextStyle? textStyle;
  final Curve curve;
  final Widget? child;
  final VoidCallback? onAnimationComplete;
  final bool autoStart;

  const ValuePopUp({
    super.key,
    required this.beginValue,
    required this.endValue,
    required this.duration,
    this.textStyle,
    this.curve = Curves.easeInOut,
    this.child,
    this.onAnimationComplete,
    this.autoStart = true,
  });

  @override
  _ValuePopUpState createState() => _ValuePopUpState();
}

class _ValuePopUpState extends State<ValuePopUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);

    _animation =
        IntTween(begin: widget.beginValue, end: widget.endValue).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            widget.onAnimationComplete?.call();
          }
        });

    if (widget.autoStart) {
      _controller.forward();
    }
  }

  void startAnimation() {
    _controller.forward();
  }

  void reverseAnimation() {
    _controller.reverse();
  }

  void resetAnimation() {
    _controller.reset();
  }

  void restartAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return widget.child ??
            Text(
              _animation.value.toString(),
              style:
                  widget.textStyle ??
                  TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: _getTextColor(),
                  ),
            );
      },
    );
  }

  Color _getTextColor() {
    if (widget.beginValue < widget.endValue) {
      return Colors.green; // Increment - Green
    } else if (widget.beginValue > widget.endValue) {
      return Colors.red; // Decrement - Red
    } else {
      return Colors.blue; // Same value - Blue
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
