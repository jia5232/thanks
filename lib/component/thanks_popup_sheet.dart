import 'package:flutter/material.dart';
import '../const/colors.dart';

class ThanksPopupSheet extends StatelessWidget {
  final onUpdatePressed;
  final onDeletePressed;
  final String thankContent;
  final DateTime thankCreatedAt;

  const ThanksPopupSheet({
    required this.onUpdatePressed,
    required this.onDeletePressed,
    required this.thankContent,
    required this.thankCreatedAt,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final textStyle = TextStyle(
      fontSize: 15.0,
    );

    return SimpleDialog(
      backgroundColor: DEEP_BEIGE,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '감사일기',
            style: textStyle
          ),
          Text(
            '${thankCreatedAt.year}.${thankCreatedAt.month}.${thankCreatedAt.day}',
            style: textStyle.copyWith(color: Colors.black45),
          ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 32.0, right: 32.0, top: 10.0, bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(thankContent),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(onPressed: onUpdatePressed, text: '수정'),
                  const SizedBox(
                    width: 60.0,
                  ),
                  CustomButton(onPressed: onDeletePressed, text: '삭제'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final onPressed;
  final String text;

  const CustomButton({
    required this.onPressed,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
