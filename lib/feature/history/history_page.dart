import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gulu_water/feature/history/widget/item_history_title.dart';

import '../../core/provider/water_data_provider.dart';
import '../../core/theme/gu_direct.dart';
import '../../model/water_record.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  final ScrollController _allWaterRecordListScrollController =
      ScrollController();

  late List<WaterRecord> _waterRecords;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _allWaterRecordListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _waterRecords = ref.watch(waterDataProvider);

    return Scaffold(body: _buildUI(context));
  }

  Widget _buildUI(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: _allWaterRecordList(context),
      );
  }

  Widget _allWaterRecordList(BuildContext context) {
    final newRecordList = recodeGroupBy(_waterRecords);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GuDirect.space8,
            vertical: GuDirect.space20,
          ),
          child: const Text(
            '飲水紀錄',
            style: TextStyle(fontSize: GuDirect.fontSize24),
          ),
        ),
        if (_waterRecords.isEmpty)
          _buildNoData()
        else
          Expanded(
            child: SafeArea(
              child: ListView.builder(
                controller: _allWaterRecordListScrollController,
                itemCount: newRecordList.length,
                itemBuilder: (context, index) {
                  final entry = newRecordList.entries.elementAt(index);
                  return ItemHistoryTitle(
                    header: entry.key,
                    records: entry.value,
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNoData() {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          'No Data',
          style: TextStyle(
            fontSize: GuDirect.fontSize24,
            color: GuDirect.textGray,
          ),
        ),
      ),
    );
  }

  Map<String, List<WaterRecord>> recodeGroupBy(List<WaterRecord> waterRecords) {
    return groupBy(waterRecords, (r) => r.date);
  }
}
