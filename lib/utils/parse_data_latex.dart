import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

RichText parseDataLatex(
  String question, {
  TextStyle? textStyle,
  double latexFontSize = 24,
}) {
  final regex = RegExp(r'\$\$(.*?)\$\$', dotAll: true);
  final matches = regex.allMatches(question);

  if (matches.isEmpty) {
    return RichText(
      text: TextSpan(
        text: question,
        style: textStyle ?? TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  List<InlineSpan> children = [];
  int lastEnd = 0;

  for (final match in matches) {
    // Text before LaTeX
    if (match.start > lastEnd) {
      children.add(
        TextSpan(
          text: question.substring(lastEnd, match.start),
          style: textStyle ?? TextStyle(fontSize: 20, color: Colors.black),
        ),
      );
    }

    // LaTeX content
    children.add(
      WidgetSpan(
        child: Math.tex(
          match.group(1)!.trim(),
          textStyle: TextStyle(fontSize: latexFontSize),
        ),
        alignment: PlaceholderAlignment.middle,
      ),
    );

    lastEnd = match.end;
  }

  if (lastEnd < question.length) {
    children.add(
      TextSpan(
        text: question.substring(lastEnd),
        style: textStyle ?? TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  return RichText(text: TextSpan(children: children));
}
