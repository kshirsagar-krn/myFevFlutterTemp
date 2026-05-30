import 'package:flutter/material.dart';

class CustomFormattedText extends StatelessWidget {
  final String text;
  final TextStyle? baseStyle;
  final TextStyle boldStyle;
  final TextStyle italicStyle;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;

  const CustomFormattedText({
    super.key,
    required this.text,
    this.baseStyle,
    this.boldStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.italicStyle = const TextStyle(fontStyle: FontStyle.italic),
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      text: _parseFormattedText(text),
    );
  }

  TextSpan _parseFormattedText(String input) {
    final List<TextSpan> children = [];
    int i = 0;

    while (i < input.length) {
      // Check for bold **
      if (i + 1 < input.length && input.substring(i, i + 2) == '**') {
        final endIndex = input.indexOf('**', i + 2);
        if (endIndex != -1) {
          // Add text before bold
          if (i > 0) {
            children.add(
              TextSpan(text: input.substring(0, i), style: baseStyle),
            );
          }

          // Add bold text
          final boldText = input.substring(i + 2, endIndex);
          children.add(
            TextSpan(text: boldText, style: _mergeStyles(baseStyle, boldStyle)),
          );

          // Continue parsing after bold section
          final remainingText = input.substring(endIndex + 2);
          children.add(_parseFormattedText(remainingText));
          break;
        }
      }

      // Check for italic *
      if (input[i] == '*') {
        final endIndex = input.indexOf('*', i + 1);
        if (endIndex != -1) {
          // Add text before italic
          if (i > 0) {
            children.add(
              TextSpan(text: input.substring(0, i), style: baseStyle),
            );
          }

          // Add italic text
          final italicText = input.substring(i + 1, endIndex);
          children.add(
            TextSpan(
              text: italicText,
              style: _mergeStyles(baseStyle, italicStyle),
            ),
          );

          // Continue parsing after italic section
          final remainingText = input.substring(endIndex + 1);
          children.add(_parseFormattedText(remainingText));
          break;
        }
      }

      i++;
    }

    // If no formatting was found, return the whole text
    if (children.isEmpty) {
      return TextSpan(text: input, style: baseStyle);
    }

    return TextSpan(children: children, style: baseStyle);
  }

  TextStyle? _mergeStyles(TextStyle? base, TextStyle additional) {
    if (base == null) return additional;
    return base.merge(additional);
  }
}
