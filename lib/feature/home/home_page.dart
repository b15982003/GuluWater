import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gulu_water/feature/home/provider/today_water_record_provider.dart';
import 'package:gulu_water/feature/home/provider/week_water_record_provider.dart';
import 'package:gulu_water/feature/home/widget/water_today_progress.dart';
import 'package:gulu_water/feature/home/widget/water_week_line_chart.dart';

import '../../core/provider/target_water_provider.dart';
import '../../core/routes/routes.dart';
import '../../core/theme/gu_direct.dart';
import '../../model/water_record.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Page', style: TextStyle(fontSize: GuDirect.fontSize24)),
    );
  }

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late List<WaterRecord> _toDayWaterRecords;
  late List<double> _weekWaterRecords;
  late double _targetWater;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _toDayWaterRecords = ref.watch(toDayWaterRecordProvider);
    _weekWaterRecords = ref.watch(weekWaterRecordProvider);
    _targetWater = ref.watch(targetWaterProvider);

    var toDayTotalWaterML = _countToDayWaterML();
    return Scaffold(body: _buildUI(context, toDayTotalWaterML));
  }

  Widget _buildUI(BuildContext context, int toDayTotalWaterML) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            vertical: GuDirect.space16,
            horizontal: GuDirect.space16,
          ),
          child: Text(
            '今日飲水量',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: GuDirect.fontSize20),
          ),
        ),
        Container(
          child: toDayTotalWaterML == 0
              ? _buildTodayNoWater(context, null)
              : waterTodayProgress(context, toDayTotalWaterML),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            vertical: GuDirect.space16,
            horizontal: GuDirect.space16,
          ),
          child: Text(
            '本週飲水量',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: GuDirect.fontSize20),
          ),
        ),
        Expanded(
          flex: 1,
          child: WaterWeekLineChart(
            data: [
              FlSpot(0, 0),
              FlSpot(1, _weekWaterRecords.isEmpty ? 0 : _weekWaterRecords[0]),
              FlSpot(2, _weekWaterRecords.isEmpty ? 0 : _weekWaterRecords[1]),
              FlSpot(3, _weekWaterRecords.isEmpty ? 0 : _weekWaterRecords[2]),
              FlSpot(4, _weekWaterRecords.isEmpty ? 0 : _weekWaterRecords[3]),
              FlSpot(5, _weekWaterRecords.isEmpty ? 0 : _weekWaterRecords[4]),
              FlSpot(6, _weekWaterRecords.isEmpty ? 0 : _weekWaterRecords[5]),
              FlSpot(7, _weekWaterRecords.isEmpty ? 0 : _weekWaterRecords[6]),
            ],
            target: _targetWater,
            dates: _getDateList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTodayNoWater(BuildContext context, Widget? child) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      radius: MediaQuery.of(context).size.width / 4,
      child: TextButton(
        onPressed: () {
          _navigateAddRecordPage(context);
        },
        child: Text(
          '開始紀錄',
          style: TextStyle(
            fontSize: GuDirect.fontSize28,
            color: GuDirect.textWhite,
          ),
        ),
      ),
    );
  }

  int _countToDayWaterML() {
    int count = 0;
    for (var record in _toDayWaterRecords) {
      count += record.value;
    }
    return count;
  }

  List<String> _getDateList() {
    List<String> dateList = ['0'];

    DateTime today = DateTime.now();
    for (int i = 6; i >= 0; i--) {
      final day = today.subtract(Duration(days: i));
      final formatted = '${day.month}/${day.day}';
      dateList.add(formatted);
    }

    return dateList;
  }

  void _navigateAddRecordPage(BuildContext context) {
    Navigator.pushNamed(context, '/${GuRoutes.ADD_RECORD_PAGE}');
  }
}
