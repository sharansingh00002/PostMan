import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  BoldText({
    this.text,
    this.fontSize = 16,
    this.positionsToBold,
    this.color,
  });

  final String text;
  final List<int> positionsToBold;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> textSpanList = [];
    final int wordsLength = text.trim().split(' ').length;
    text.trim().split(' ').asMap().forEach(
      (i, word) {
        (positionsToBold.contains(i))
            ? textSpanList.add(
                TextSpan(
                  text: (wordsLength - 1 == i) ? word : '$word ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: color,
                  ),
                ),
              )
            : textSpanList.add(
                TextSpan(
                  text: (wordsLength - 1 == i) ? word : '$word ',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.normal,
                    color: color,
                  ),
                ),
              );
      },
    );

    return RichText(
      text: TextSpan(
        children: textSpanList,
        style: DefaultTextStyle.of(context).style,
      ),
    );
  }
}
