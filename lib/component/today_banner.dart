import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thanks_life_daily/const/colors.dart';
import 'package:thanks_life_daily/database/drift_database.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;

  const TodayBanner({
    required this.selectedDay,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일의 감사일기',
              style: textStyle,
            ),
            StreamBuilder<List<Thank>>(
              stream: GetIt.I<LocalDatabase>().watchDateSelectedThanks(selectedDay),
              builder: (context, snapshot) {
                int count = 0;

                if(snapshot.hasData){
                  count = snapshot.data!.length;
                }

                return Text(
                  '${count}개',
                  style: textStyle,
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
