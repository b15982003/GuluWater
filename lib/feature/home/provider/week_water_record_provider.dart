import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:gulu_water/model/water_record.dart';

import '../../../data/water_db_helper.dart';

final weekWaterRecordProvider =
    StateNotifierProvider<WeekWaterDataProvider, List<double>>(
      (ref) => WeekWaterDataProvider([]),
    );

class WeekWaterDataProvider extends StateNotifier<List<double>> {
  final WaterDbHelper waterDbHelper = GetIt.instance.get<WaterDbHelper>();

  WeekWaterDataProvider(super._state) {
    _setup();
  }

  Future<void> _setup() async {
    updateWeekWaterRecord();
  }

  Future<void> updateWeekWaterRecord() async {
    List<double> datesTotalWaterML = [];
    final dates = _getDateList();

    for (var date in dates) {
      final waterRecords = await waterDbHelper.queryWaterRecordsByDate(date);
      datesTotalWaterML.add(_countToDayWaterML(waterRecords).toDouble());
    }

    state = datesTotalWaterML;
  }

  int _countToDayWaterML(List<WaterRecord> waterRecords) {
    int count = 0;
    for (var record in waterRecords) {
      count += record.value;
    }
    return count;
  }

  List<String> _getDateList() {
    List<String> dateList = [];

    DateTime today = DateTime.now();
    for (int i = 6; i >= 0; i--) {
      final day = today.subtract(Duration(days: i));
      dateList.add(day.toString().split(" ")[0]);
    }

    return dateList;
  }
}
