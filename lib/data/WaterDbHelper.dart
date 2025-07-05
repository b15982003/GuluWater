import 'package:gulu_water/data/GuDataBase.dart';
import 'package:sqflite/sqflite.dart';

import '../model/WaterRecord.dart';

class WaterDbHelper {
  WaterDbHelper();

  static const water_table_name = 'water_table_name';

  Database? _database;

  Future<Database> get database async =>
      _database ??= await GuDataBase().database;

  void insertWaterRecord(WaterRecord waterRecord) async {
    final db = await database;
    await db.insert(
      water_table_name,
      waterRecord.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<WaterRecord>> queryWaterRecords(String waterTimestamp) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      water_table_name,
      columns: [
        WaterRecord.waterType,
        WaterRecord.waterValue,
        WaterRecord.waterTimestamp,
        WaterRecord.waterNote,
      ],
      where: '${WaterRecord.waterTimestamp} = ?',
      whereArgs: [waterTimestamp],
    );
    return _waterRecordsToList(maps);
  }

  void deleteWaterRecord(String waterTimestamp) async {
    final db = await database;
    await db.delete(
      water_table_name,
      where: '${WaterRecord.waterTimestamp} = ?',
      whereArgs: [waterTimestamp],
    );
  }

  Future<List<WaterRecord>> getAllWaterRecords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(water_table_name);
    return _waterRecordsToList(maps);
  }

  List<WaterRecord> _waterRecordsToList(
    List<Map<String, dynamic>>? mapWaterRecord,
  ) {
    var waterRecords = List.generate(
      mapWaterRecord?.length ?? 0,
      (index) => WaterRecord(
        type: mapWaterRecord?[index][WaterRecord.waterType],
        value: mapWaterRecord?[index][WaterRecord.waterValue],
        timeStamp: mapWaterRecord?[index][WaterRecord.waterTimestamp],
        note: mapWaterRecord?[index][WaterRecord.waterNote],
      ),
    );
    return waterRecords;
  }
}
