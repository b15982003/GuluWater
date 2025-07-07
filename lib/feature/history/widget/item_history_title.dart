import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gulu_water/core/theme/gu_direct.dart';
import 'package:gulu_water/core/widget/gu_dialog.dart';
import 'package:gulu_water/model/water_record.dart';

import '../../../core/provider/water_data_provider.dart';
import '../../home/provider/today_water_record_provider.dart';
import '../../home/provider/week_water_record_provider.dart';

class ItemHistoryTitle extends ConsumerWidget {
  final String header;
  final List<WaterRecord> records;

  const ItemHistoryTitle({required this.header, required this.records, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _waterDataProvider = ref.watch(waterDataProvider.notifier);
    final _toDayWaterDataProvider = ref.watch(
      toDayWaterRecordProvider.notifier,
    );
    final _weekWaterDataProvider = ref.watch(weekWaterRecordProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: GuDirect.backgroundLightGray,
          padding: const EdgeInsets.symmetric(vertical: GuDirect.space12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: GuDirect.space16),
            child: Text(
              header,
              style: const TextStyle(fontSize: GuDirect.fontSize20),
            ),
          ),
        ),
        ...records.map(
          (record) => _item(
            context,
            record,
            records.last != record,
            _waterDataProvider,
            _toDayWaterDataProvider,
            _weekWaterDataProvider,
          ),
        ),
      ],
    );
  }

  Widget _item(
    BuildContext context,
    WaterRecord waterRecord,
    bool showUnderLine,
    WaterDataProvider waterDataProvider,
    ToDayWaterDataProvider toDayWaterDataProvider,
    WeekWaterDataProvider weekWaterDataProvider,
  ) {
    return Column(
      children: [
        GestureDetector(
          onLongPress: () async {
            var ans = await guDialog(
              context: context,
              title: '',
              content: '確定要刪除嗎？',
            );
            if (ans == 1) {
              waterDataProvider.deleteWaterRecord(waterRecord);
              toDayWaterDataProvider.updateWaterRecord();
              weekWaterDataProvider.updateWeekWaterRecord();
            }
          },
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: GuDirect.space20,
            ),
            title: Text(
              '${waterRecord.value} ml',
              style: TextStyle(fontSize: GuDirect.fontSize18),
            ),
            subtitle: Text(
              '${waterRecord.date} ${waterRecord.time}',
              style: TextStyle(fontSize: GuDirect.fontSize16),
            ),
          ),
        ),
        if (showUnderLine) const Divider(),
      ],
    );
  }
}
