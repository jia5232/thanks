import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:thanks_life_daily/database/drift_database.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:thanks_life_daily/screen/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    final customDarkTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'NotoSans',
    );

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode currentMode, __){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''), // English, no country code
            Locale('ko', ''),
          ],
          theme: ThemeData(
            fontFamily: 'NotoSans',
          ),
          darkTheme: customDarkTheme,
          themeMode: currentMode,
          home: MainScreen(),
        );
      },
    );
  }
}