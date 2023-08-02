import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:thanks_life_daily/database/drift_database.dart';
import 'package:thanks_life_daily/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:thanks_life_daily/screen/main_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(
    MaterialApp(
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
      darkTheme: ThemeData.dark(),
      home: MainScreen(),
    ),
  );
}