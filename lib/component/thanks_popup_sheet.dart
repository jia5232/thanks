import 'package:flutter/material.dart';
import '../const/colors.dart';

class ThanksPopupSheet extends StatelessWidget {
  final onUpdatePressed;
  final onDeletePressed;
  final String thankContent;

  const ThanksPopupSheet({
    required this.onUpdatePressed,
    required this.onDeletePressed,
    required this.thankContent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: DEEP_BEIGE,
      title: Text(
        '감사일기',
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 32.0, right: 32.0, top: 10.0, bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(thankContent),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(onPressed: onUpdatePressed, text: '수정'),
                  SizedBox(
                    width: 50.0,
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
