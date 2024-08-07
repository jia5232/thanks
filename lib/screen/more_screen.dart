import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:package_info/package_info.dart';
import 'package:thanks_life_daily/const/colors.dart';
import 'package:thanks_life_daily/main.dart';

import '../notification/notification.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  void initState() {
    FlutterLocalNotification.init();
    Future.delayed(
      const Duration(seconds: 3),
      FlutterLocalNotification.requestNotificationPermission(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20.0,
    );

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '더보기',
                  style: textStyle,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  CustomTextButton(
                    icon: Icons.phone_iphone,
                    title: '앱 정보',
                    onPressed: onInformationPressed,
                  ),
                  // CustomTextButton(
                  //   icon: Icons.question_mark,
                  //   title: '도움말',
                  //   onPressed: onHelpDeskPressed,
                  // ),
                  CustomTextButton(
                    icon: Icons.person,
                    title: '문의하기',
                    onPressed: onContactPressed,
                  ),
                  CustomTextButton(
                    icon: MyApp.themeNotifier.value == ThemeMode.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    title: MyApp.themeNotifier.value == ThemeMode.light
                        ? '다크모드로 변경'
                        : '라이트모드로 변경',
                    onPressed: onDarkLightPressed,
                  ),
                  // CustomTextButton(
                  //   icon: Icons.notifications,
                  //   title: '푸시알림 설정',
                  //   onPressed: () async {
                  //     FlutterLocalNotification.showNotification();
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onInformationPressed() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: DEEP_BEIGE,
          title: Text("앱 정보"),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 32.0, right: 32.0, top: 10.0, bottom: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('앱 이름'),
                      const SizedBox(
                        width: 30.0,
                      ),
                      Text('Thanks'),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Text('앱 버전'),
                      const SizedBox(
                        width: 30.0,
                      ),
                      Text(info.version),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void onContactPressed() async {
    final Email email = Email(
        body: '문의할 사항을 아래에 작성해주세요.',
        subject: '[thanks 문의]',
        recipients: ['99jiasmin@gmail.com'],
        cc: [],
        bcc: [],
        attachmentPaths: [],
        isHTML: false);

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      String title = '문의하기';
      String message = '기본 메일 앱을 사용할 수 없습니다. 이메일로 연락주세요! 99jiasmin@gmail.com';
      showErrorAlert(title, message);
    }
  }

  void onDarkLightPressed() {
    MyApp.themeNotifier.value = MyApp.themeNotifier.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    setState(() {});
  }

  void showErrorAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: DEEP_BEIGE,
          title: Text(
            title,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 32.0, right: 32.0, top: 10.0, bottom: 10.0),
              child: Column(
                children: [
                  Text(message),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const CustomTextButton({
    required this.icon,
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                color: MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ],
        ),
        style: TextButton.styleFrom(
          foregroundColor: PRIMARY_COLOR,
        ),
      ),
    );
  }
}