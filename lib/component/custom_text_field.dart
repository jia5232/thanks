import 'package:flutter/material.dart';
import 'package:thanks_life_daily/const/colors.dart';

class CustomTextField extends StatelessWidget {
  final String lable;

  const CustomTextField({
    required this.lable,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
          style: TextStyle(
            color: Colors.black45,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: TextFormField(
            // validator : null이 리턴되면 에러가 없다.
            // 에러가 있으면 에러를 String 값으로 리턴해준다.
            validator: (String? val){

            },
            expands: true,
            cursorColor: Colors.black,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white70,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.pink.shade100),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.pink.shade200),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
