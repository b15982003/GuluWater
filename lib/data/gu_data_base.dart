import 'package:gulu_water/data/water_db_helper.dart';
import 'package:gulu_water/model/water_record.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GuDataBase {
  static final GuDataBase _instance = GuDataBase._privConstructor();
  factory GuDataBase() => _instance;
  GuDataBase._privConstructor();

  static const GuDbName = 'gu_db.db';

  static Database? _database;

  Future<Database> get database async => _database ??= await openDb();

  static Future<Database> openDb() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, GuDbName);

    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        db.execute(
          'CREATE TABLE ${WaterDbHelper.water_table_name}('
          'id INTEGER PRIMARY KEY,'
          ' ${WaterRecord.waterType} TEXT,'
          ' ${WaterRecord.waterValue} INTEGER,'
          ' ${WaterRecord.waterDate} TEXT,'
          ' ${WaterRecord.waterTime} TEXT,'
          ' ${WaterRecord.waterTimestamp} INTEGER,'
          ' ${WaterRecord.waterNote} TEXT)',
        );
      },
    );

    return db;
  }

  closeDb() async {
    final db = await database; // 用 getter 取得資料庫
    await db.close();
  }
}
