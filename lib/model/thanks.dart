import 'package:drift/drift.dart';

class Thanks extends Table {
  //PRIMARY KEY
  IntColumn get id => integer().autoIncrement()();

  //내용
  TextColumn get content => text()();

  //날짜
  DateTimeColumn get date => dateTime()();

  //생성 날짜
  DateTimeColumn get createdAt => dateTime().clientDefault(
        () => DateTime.now(),
      )();
}
