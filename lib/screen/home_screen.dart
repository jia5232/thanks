import 'package:flutter/material.dart';
import 'package:thanks_life_daily/component/calendar.dart';
import 'package:thanks_life_daily/component/schedule_card.dart';
import 'package:thanks_life_daily/component/thanks_bottom_sheet.dart';
import 'package:thanks_life_daily/component/thanks_card.dart';
import 'package:thanks_life_daily/component/today_banner.dart';
import 'package:thanks_life_daily/const/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionButton(),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              selectedDay: selectedDay,
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0),
            TodayBanner(
              selectedDay: selectedDay,
              scheduleCount: 4,
            ),
            SizedBox(height: 8.0),
            _ThanksCardList(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(context: context, isScrollControlled: true, builder: (_){
          return ThanksBottomSheet();
        });
      },
      backgroundColor: PRIMARY_COLOR,
      child: Icon(Icons.add),
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}

class _ThanksCardList extends StatelessWidget {
  const _ThanksCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.separated(
            itemCount: 3,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 8.0,
              );
            },
            itemBuilder: (context, index) {
              return ThanksCard(
                number: (index + 1).toString(),
                content: '모두 건강함에 감사',
              );
            }),
      ),
    );
  }
}
