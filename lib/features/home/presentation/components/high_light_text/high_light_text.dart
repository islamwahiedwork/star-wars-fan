import 'package:flutter/material.dart';
import 'package:star_wars_app/core/utils/global.dart';
import 'package:substring_highlight/substring_highlight.dart';

class HighlightedTextWidget extends StatelessWidget {
  final String titleText;
  final String text;

  const HighlightedTextWidget({
    super.key,
    required this.titleText,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          titleText,
          textAlign: TextAlign.start,
        ),
        Flexible(
          child: SubstringHighlight(
            textStyleHighlight: TextStyle(
              backgroundColor: Colors.orange.withOpacity(0.3),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            textStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
            text: text,
            term: Global.txtSearchController.text,
          ),
        ),
      ],
    );
  }
}

class HighlightedTextWidgetForHeader extends StatelessWidget {
  final String text;

  const HighlightedTextWidgetForHeader({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SubstringHighlight(
      textStyleHighlight: TextStyle(
        backgroundColor: Colors.orange.withOpacity(0.3),
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: text,
      term: Global.txtSearchController.text,
      textAlign: TextAlign.center,
    );
  }
}
