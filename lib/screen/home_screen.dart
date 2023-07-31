import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thanks_life_daily/component/calendar.dart';
import 'package:thanks_life_daily/component/thanks_bottom_sheet.dart';
import 'package:thanks_life_daily/component/thanks_card.dart';
import 'package:thanks_life_daily/component/today_banner.dart';
import 'package:thanks_life_daily/const/colors.dart';
import 'package:thanks_life_daily/database/drift_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
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
            _ThanksCardList(
              selectedDate: selectedDay,
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) {
              return ThanksBottomSheet(
                selectedDate: selectedDay,
              );
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
                GetIt.I<LocalDatabase>().watchDateSelectedThanks(selectedDate),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    '나만의 감사일기를 작성해보세요!',
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

                    return ThanksCard(
                      number: (index + 1).toString(),
                      content: thank.content,
                    );
                  });
            }),
      ),
    );
  }
}
