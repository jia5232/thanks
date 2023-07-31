import 'package:flutter/material.dart';
import 'package:thanks_life_daily/component/custom_text_field.dart';
import 'package:thanks_life_daily/const/colors.dart';

class ThanksBottomSheet extends StatelessWidget {
  const ThanksBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        height: MediaQuery.of(context).size.height/2 + bottomInset/2,
        color: Colors.pink.shade50,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Padding(
            padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 10.0, bottom: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),
                Expanded(
                  child: CustomTextField(
                    lable: '오늘의 감사한 일',
                  ),
                ),
                SizedBox(height: 8.0),
                _SaveButton(),
                SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('저장'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(CORAL_PINK),

            ),
          ),
        ),
      ],
    );
  }
}
