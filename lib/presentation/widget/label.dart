import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String text;
  final TextStyle? style;

  final TextAlign textAlign;
  final int? maxLine;

  const Label(this.text, {super.key, this.style, this.textAlign = TextAlign.left, this.maxLine});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      textScaler: TextScaler.noScaling,
      maxLines: maxLine,
    );
  }
}
