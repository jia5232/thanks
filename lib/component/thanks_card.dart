import 'package:flutter/material.dart';
import 'package:thanks_life_daily/const/colors.dart';

class ThanksCard extends StatelessWidget {
  final String number;
  final String content;

  const ThanksCard({
    required this.number,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LIGHT_CORAL,
        border: Border.all(
          width: 1.0,
          color: BEIGE,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Content(number: number, content: content),
            ],
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final String number;
  final String content;

  const _Content({
    required this.number,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMARY_COLOR,
      fontSize: 16.0,
    );

    return Expanded(
      child: Row(
        children: [
          Text(
            number,
            style: textStyle,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              content,
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}
