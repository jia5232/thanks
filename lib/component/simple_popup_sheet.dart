import 'package:flutter/material.dart';

import '../const/colors.dart';

class SimplePopupSheet extends StatelessWidget {
  final String title;

  const SimplePopupSheet({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 15.0,
    );

    return SimpleDialog(
      backgroundColor: DEEP_BEIGE,
      title: Text(title),
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 32.0, right: 32.0, top: 10.0, bottom: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: '취소',
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
