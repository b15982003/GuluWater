import 'package:get_it/get_it.dart';
import 'package:gulu_water/data/water_db_helper.dart';
import 'package:gulu_water/model/water_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final waterDataProvider =
    StateNotifierProvider<WaterDataProvider, List<WaterRecord>>(
      (ref) => WaterDataProvider([]),
    );

class WaterDataProvider extends StateNotifier<List<WaterRecord>> {
  final WaterDbHelper waterDbHelper = GetIt.instance.get<WaterDbHelper>();

  WaterDataProvider(super._state) {
    _setup();
  }

  Future<void> _setup() async {
    // TODO 之後改成先抓一個月內
    final waterRecords = await waterDbHelper.getAllWaterRecords();
    state = waterRecords ?? [];
  }

  Future<void> addWaterRecord(WaterRecord waterRecord) async {
    waterDbHelper.insertWaterRecord(waterRecord);
    final waterRecords = await waterDbHelper.getAllWaterRecords();
    state = waterRecords ?? [];
  }

  Future<void> deleteWaterRecord(WaterRecord waterRecord) async {
    waterDbHelper.deleteWaterRecord(waterRecord.date, waterRecord.timeStamp);
    final waterRecords = await waterDbHelper.getAllWaterRecords();
    state = waterRecords ?? [];
  }
}
