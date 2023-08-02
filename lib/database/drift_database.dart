//private값들은 불러올 수 없다.
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thanks_life_daily/model/thanks.dart';
import 'package:path/path.dart' as p;

//private값들도 불러올 수 있다.
part 'drift_database.g.dart';

@DriftDatabase(
  tables: [Thanks,]
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  //쿼리
  Future<Thank> getThankById(int id) =>
      (select(thanks)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<int> createThank(ThanksCompanion data) =>
      into(thanks).insert(data);

  Future<int> removeThank(int id) =>
      (delete(thanks)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> updateThankById(int id, ThanksCompanion data) =>
      (update(thanks)..where((tbl) => tbl.id.equals(id))).write(data);

  Stream<List<Thank>> watchDateSelectedThanks(DateTime date){
    final query = select(thanks); //1.query에 where라는 필터를 적용해줌.
    query.where((tbl) => tbl.date.equals(date)); //2.select에서 바로 watch가 되도록 연결해줌.
    return query.watch();

    // return (select(thanks)..where((tbl)=> tbl.date.equals(date))).watch();
    // //..을 쓰면 where문은 실행이 되는데 watch입장에서 리턴으로 돌아오는 값은 그 앞에 있는 select이다. 그래서 에러가 없어진다.
  }

  Stream<List<Thank>> watchMonthSelectedThanks(DateTime date){
    final query = select(thanks);
    query.where((tbl) => tbl.date.year.equals(date.year) & tbl.date.month.equals(date.month));
    query.orderBy([(tbl) => OrderingTerm(expression: tbl.date)]);
    return query.watch();
  }

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection(){
  return LazyDatabase(() async {
    //사용할 수 있도록 배정받은 db폴더의 위치를 가져옴
    final dbFolder = await getApplicationDocumentsDirectory();
    //그 경로에 'db.sqlite'이라는 파일을 만든다.
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    //그 파일로 데이터베이스를 만든다.
    return NativeDatabase(file);
  });
}