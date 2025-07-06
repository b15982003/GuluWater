import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gulu_water/feature/history/widget/ItemHistoryTitle.dart';
import "package:collection/collection.dart";

import '../../core/provider/WaterDataProvider.dart';
import '../../core/theme/GuDirect.dart';
import '../../model/WaterRecord.dart';

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
    print('history init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _waterRecords = ref.watch(waterDataProvider);
    print('history build');
    return Scaffold(body: _buildUI(context));
  }

  Widget _buildUI(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_allWaterRecordList(context)],
          ),
        ),
      ),
    );
  }

  Widget _allWaterRecordList(BuildContext context) {
    final newRecordList = recodeGroupBy(_waterRecords);
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: GuDirect.space8, vertical: GuDirect.space20),
            child: const Text(
              '飲水紀錄',
              style: TextStyle(fontSize: GuDirect.fontSize24),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.6,
            child: ListView.builder(
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
        ],
      ),
    );
  }

  Map<String, List<WaterRecord>> recodeGroupBy(List<WaterRecord> waterRecords) {
    return groupBy(waterRecords, (r) => r.date);
  }
}
