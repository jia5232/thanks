import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thanks_life_daily/database/drift_database.dart';
import '../component/thanks_bottom_sheet.dart';
import '../component/thanks_card.dart';
import '../component/thanks_popup_sheet.dart';
import '../const/colors.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late DateTime selectedDate;
  late DateTime picked;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    picked = DateTime.now();
  }

  final monthTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.black54,
    fontSize: 14.0,
  );

  Future<void> _selectDate(BuildContext context) async {
    picked = await SimpleMonthYearPicker
        .showMonthYearPickerDialog(
      context: context,
      titleTextStyle: monthTextStyle,
      monthTextStyle: monthTextStyle,
      yearTextStyle: monthTextStyle,
      barrierDismissible: true,
      disableFuture: true,
      backgroundColor: DEEP_BEIGE,
      selectionColor: PRIMARY_COLOR,
      newSelectedDate: picked,
    );
    if( picked != null && picked != selectedDate){
      setState(() {
        selectedDate = DateTime(picked.year, picked.month);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: 16.0,
    );

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8.0,
            ),
            Text(
              '월별 감사일기 모아보기',
              style: titleTextStyle,
            ),
            const SizedBox(
              height: 8.0,
            ),
            _ThanksCardList(
              selectedDate: selectedDate,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(PRIMARY_COLOR),
                      ),
                      onPressed: () => _selectDate(context),
                      child: Text('날짜 고르기'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThanksCardList extends StatelessWidget {
  final DateTime selectedDate;

  const _ThanksCardList({
    required this.selectedDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<Thank>>(
          stream:
              GetIt.I<LocalDatabase>().watchMonthSelectedThanks(selectedDate),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  '해당 날짜에 기록된 감사일기가 없습니다.',
                  style: TextStyle(color: Colors.black45),
                ),
              );
            }

            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 8.0,
                );
              },
              itemBuilder: (context, index) {
                final thank = snapshot.data![index];

                return GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ThanksPopupSheet(
                            onUpdatePressed: () {
                              Navigator.of(context).pop();
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (_) {
                                  return ThanksBottomSheet(
                                    date: thank.date,
                                    selectedDate: selectedDate,
                                    thankId: thank.id,
                                  );
                                },
                              );
                            },
                            onDeletePressed: () {
                              GetIt.I<LocalDatabase>().removeThank(thank.id);
                              Navigator.of(context).pop();
                            },
                            thankContent: thank.content,
                            thankCreatedAt: thank.date,
                          );
                        });
                  },
                  child: ThanksCard(
                    number: (index + 1).toString(),
                    content: thank.content,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
