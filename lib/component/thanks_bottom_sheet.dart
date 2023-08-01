import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thanks_life_daily/component/custom_text_field.dart';
import 'package:thanks_life_daily/const/colors.dart';
import 'package:thanks_life_daily/database/drift_database.dart';
import 'package:drift/drift.dart' show Value;

class ThanksBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final int? thankId;

  const ThanksBottomSheet({
    required this.selectedDate,
    this.thankId,
    super.key,
  });

  @override
  State<ThanksBottomSheet> createState() => _ThanksBottomSheetState();
}

class _ThanksBottomSheetState extends State<ThanksBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? content;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: FutureBuilder<Thank>(
          future: widget.thankId == null
              ? null
              : GetIt.I<LocalDatabase>().getThankById(widget.thankId!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('스케줄을 불러올 수 없습니다.'),
              );
            }

            //FutureBuilder가 처음 실행됐고, 로딩중일때.
            if (snapshot.connectionState != ConnectionState.none &&
                !snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            //Future가 실행되고 값이 있는데, 값이 세팅되지 않았을 때.
            if (snapshot.hasData && content == null) {
              content = snapshot.data!.content;
            }

            return Container(
              height: MediaQuery.of(context).size.height / 2 + bottomInset / 2,
              color: BEIGE,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomInset),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 32.0, right: 32.0, top: 10.0, bottom: 32.0),
                  child: Form(
                    key: formKey, //formKey는 form의 컨트롤러처럼 작동한다.
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.0),
                        Expanded(
                          child: CustomTextField(
                            lable: '오늘의 감사한 일',
                            initialValue: content ?? '',
                            onSaved: onContentSaved,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        _SaveButton(
                          onPressed: onSavePressed,
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void onSavePressed() async {
    //formKey는 생성을 했는데, Form 위젯과 결합을 안했을 때.
    if (formKey.currentState == null) {
      return;
    }

    if (formKey.currentState!.validate()) {
      //validate를 통과하고 에러가 없으면 true.
      formKey.currentState!
          .save(); //form을 save하면 form안에 있는 모든 텍스트 필드의 onSaved가 실행됨.

      if (widget.thankId == null) {
        await GetIt.I<LocalDatabase>().createThank(
          ThanksCompanion(
            date: Value(widget.selectedDate),
            content: Value(content!),
          ),
        );
      } else {
        await GetIt.I<LocalDatabase>().updateThankById(
          widget.thankId!,
          ThanksCompanion(
            date: Value(widget.selectedDate),
            content: Value(content!),
          ),
        );
      }

      Navigator.of(context).pop();
    } else {
      //에러가 있는 경우
      print('에러가 있습니다.');
    }
  }

  void onContentSaved(String? val) {
    content = val;
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text('저장'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(CORAL),
            ),
          ),
        ),
      ],
    );
  }
}
