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
  Future<int> createThank(ThanksCompanion data) =>
      into(thanks).insert(data);

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