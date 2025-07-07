import 'package:gulu_water/data/gu_data_base.dart';
import 'package:sqflite/sqflite.dart';

import '../model/water_record.dart';

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

  Future<List<WaterRecord>> queryWaterRecordsByDate(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      water_table_name,
      columns: [
        WaterRecord.waterType,
        WaterRecord.waterValue,
        WaterRecord.waterDate,
        WaterRecord.waterTime,
        WaterRecord.waterTimestamp,
        WaterRecord.waterNote,
      ],
      where: '${WaterRecord.waterDate} = ?',
      whereArgs: [date],
    );
    return _waterRecordsToList(maps);
  }

  void deleteWaterRecord(String date, String waterTimestamp) async {
    final db = await database;
    await db.delete(
      water_table_name,
      where:
          '${WaterRecord.waterDate} = ? AND ${WaterRecord.waterTimestamp} = ?',
      whereArgs: [date, waterTimestamp],
    );
  }

  Future<List<WaterRecord>> getAllWaterRecords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      water_table_name,
      orderBy: 'timeStamp DESC',
    );
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
        date: mapWaterRecord?[index][WaterRecord.waterDate],
        time: mapWaterRecord?[index][WaterRecord.waterTime],
        timeStamp: mapWaterRecord?[index][WaterRecord.waterTimestamp],
        note: mapWaterRecord?[index][WaterRecord.waterNote],
      ),
    );
    return waterRecords;
  }
}
