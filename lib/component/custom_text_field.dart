import 'package:flutter/material.dart';
import 'package:thanks_life_daily/const/colors.dart';

class CustomTextField extends StatelessWidget {
  final String lable;
  final FormFieldSetter<String> onSaved;

  const CustomTextField({
    required this.lable,
    required this.onSaved,
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
              if(val == null || val.isEmpty){
                return "내용을 입력해주세요.";
              }else{
                if(val.length > 1000){
                  return '1000자 이하의 글자를 입력해주세요.';
                }
              }
              return null;
            },
            // onSaved : 저장되고 나면 어떤 함수를 실행하는지. (값들을 어떤 방식으로 가져갈 것인지)
            onSaved: onSaved,
            expands: true,
            cursorColor: Colors.black,
            maxLines: null,
            maxLength: 1000,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white70,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: BEIGE),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: BEIGE),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
