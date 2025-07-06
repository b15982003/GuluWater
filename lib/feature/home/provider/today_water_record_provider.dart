import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../data/water_db_helper.dart';
import '../../../model/water_record.dart';

final toDayWaterRecordProvider =
StateNotifierProvider<ToDayWaterDataProvider, List<WaterRecord>>(
      (ref) => ToDayWaterDataProvider([]),
);

class ToDayWaterDataProvider extends StateNotifier<List<WaterRecord>> {
  final WaterDbHelper waterDbHelper = GetIt.instance.get<WaterDbHelper>();

  ToDayWaterDataProvider(super._state) {
    _setup();
  }

  Future<void> _setup() async {
    updateWaterRecord();
  }

  Future<void> updateWaterRecord() async {
    final toDate = DateTime.now().toString().split(" ")[0];
    final waterRecords = await waterDbHelper.queryWaterRecordsByDate(toDate);
    state = waterRecords ?? [];
  }
}