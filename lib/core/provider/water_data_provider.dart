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
    final waterRecords = await waterDbHelper.getAllWaterRecords();
    state = waterRecords ?? [];
  }

  Future<void> addWaterRecord(WaterRecord waterRecord) async {
    waterDbHelper.insertWaterRecord(waterRecord);
    final waterRecords = await waterDbHelper.getAllWaterRecords();
    state = waterRecords ?? [];
  }
}
