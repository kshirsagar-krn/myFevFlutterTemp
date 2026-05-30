import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/constant/app_color.dart';

// ─────────────────────────────────────────────
//  OtpController – programmatic control
// ─────────────────────────────────────────────

/// Attach to [OtpInput] via the [controller] param.
/// Exposes: clear(), setError(), clearError(), setValue().
class OtpController {
  _OtpInputState? _state;

  String get value => _state?._controller.text ?? '';

  /// Clears all fields and resets to idle.
  void clear() => _state?._clearAll();

  /// Fills all boxes programmatically (e.g. from SMS auto-read).
  void setValue(String otp) => _state?._setValue(otp);

  /// Triggers red-border shake + optional error message.
  void setError([String? message]) => _state?._setError(message);

  /// Resets back to idle state.
  void clearError() => _state?._clearError();

  void _attach(_OtpInputState state) => _state = state;
  void _detach() => _state = null;
}

// ─────────────────────────────────────────────
//  Internal state enum
// ─────────────────────────────────────────────

enum _OtpFieldState { idle, success, error }

// ─────────────────────────────────────────────
//  OtpInput widget
// ─────────────────────────────────────────────

class OtpInput extends StatefulWidget {
  /// Called once every digit is entered.
  final ValueChanged<String>? onCompleted;

  /// Called on every keystroke / paste / clear.
  final ValueChanged<String>? onChanged;

  /// Number of boxes (default: 6).
  final int length;

  /// Gap between each box in logical pixels (default: 8).
  final double gap;

  /// Height of each box (default: 56).
  final double boxHeight;

  /// Hides digits behind ● (useful for PIN / password).
  final bool obscureText;

  /// Focuses the first box as soon as the widget appears.
  final bool autoFocus;

  /// Optional controller for programmatic control.
  final OtpController? controller;

  const OtpInput({
    super.key,
    this.onCompleted,
    this.onChanged,
    this.length = 6,
    this.gap = 8,
    this.boxHeight = 56,
    this.obscureText = false,
    this.autoFocus = false,
    this.controller,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  _OtpFieldState _fieldState = _OtpFieldState.idle;
  String? _errorMessage;
  bool _isFocused = false;

  // Shake animation controller
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _focusNode = FocusNode();

    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_handleTextChange);

    // ── Shake animation ───────────────────────────────────────────────────
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 480),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    // ── Controller attachment ─────────────────────────────────────────────
    widget.controller?._attach(this);

    // ── Auto-focus ────────────────────────────────────────────────────────
    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _controller.removeListener(_handleTextChange);
    _controller.dispose();
    _focusNode.dispose();
    _shakeController.dispose();
    widget.controller?._detach();
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  void _handleTextChange() {
    final text = _controller.text;

    // Clear error highlights out of the box as soon as user modifies input
    if (_fieldState == _OtpFieldState.error) {
      _fieldState = _OtpFieldState.idle;
      _errorMessage = null;
    }

    widget.onChanged?.call(text);

    if (text.length == widget.length) {
      if (_fieldState != _OtpFieldState.success) {
        _fieldState = _OtpFieldState.success;
        HapticFeedback.mediumImpact();
        widget.onCompleted?.call(text);
      }
    } else {
      if (_fieldState == _OtpFieldState.success) {
        _fieldState = _OtpFieldState.idle;
      }
    }

    setState(() {});
  }

  // ─── OtpController actions ─────────────────────────────────────────────

  void _clearAll() {
    _controller.clear();
    setState(() {
      _fieldState = _OtpFieldState.idle;
      _errorMessage = null;
    });
    if (widget.autoFocus && mounted) _focusNode.requestFocus();
  }

  void _setValue(String otp) {
    final raw = otp.replaceAll(RegExp(r'\D'), '');
    final digits = raw.substring(0, min(widget.length, raw.length));
    _controller.text = digits;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: digits.length),
    );
  }

  void _setError([String? message]) {
    setState(() {
      _fieldState = _OtpFieldState.error;
      _errorMessage = message;
    });
    HapticFeedback.vibrate();
    _shakeController.forward(from: 0);
  }

  void _clearError() {
    setState(() {
      _fieldState = _OtpFieldState.idle;
      _errorMessage = null;
    });
  }

  // ─── Color / border helpers ────────────────────────────────────────────

  Color _borderColor(bool focused) {
    switch (_fieldState) {
      case _OtpFieldState.error:
        return Colors.red.shade400;
      case _OtpFieldState.success:
        return Colors.green.shade400;
      case _OtpFieldState.idle:
        return focused ? AppColor.primaryColor : Colors.transparent;
    }
  }

  Color _fillColor(bool focused) {
    switch (_fieldState) {
      case _OtpFieldState.error:
        return Colors.red.shade50;
      case _OtpFieldState.success:
        return Colors.green.shade50;
      case _OtpFieldState.idle:
        return focused
            ? AppColor.primaryColor.withOpacity(0.06)
            : AppColor.lightBorder;
    }
  }

  // ─── Build ─────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        final shakeOffset = _fieldState == _OtpFieldState.error
            ? sin(_shakeAnimation.value * pi * 6) * 8.0
            : 0.0;
        return Transform.translate(
          offset: Offset(shakeOffset, 0),
          child: child,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Stack: Real Invisible TextField layered over custom boxes ──
          Stack(
            children: [
              Row(
                children: [
                  for (int index = 0; index < widget.length; index++) ...[
                    if (index > 0) SizedBox(width: widget.gap),
                    Expanded(child: _buildOtpBox(index)),
                  ],
                ],
              ),
              Positioned.fill(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  maxLength: widget.length,
                  showCursor: false,
                  enableInteractiveSelection: false,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  // Completely transparent look so your design shines below
                  style: const TextStyle(
                    color: Colors.transparent,
                    fontSize: 1,
                  ),
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onTapOutside: (_) => _focusNode.unfocus(),
                ),
              ),
            ],
          ),

          // ── Error message ─────────────────────────────────────────────
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: _errorMessage != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 14,
                          color: Colors.red.shade400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _errorMessage!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    final text = _controller.text;

    // Modern active state: highlight the box the cursor is sitting on
    final isBoxFocused = _isFocused && (index == text.length);

    String displayChar = '';
    if (index < text.length) {
      displayChar = widget.obscureText ? '●' : text[index];
    }

    return SizedBox(
      height: widget.boxHeight,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: _fillColor(isBoxFocused),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _borderColor(isBoxFocused), width: 2),
        ),
        child: Center(
          child: Text(
            displayChar,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
