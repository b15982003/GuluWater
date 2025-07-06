import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gulu_water/core/theme/GuDirect.dart';
import 'package:gulu_water/model/WaterRecord.dart';

class ItemHistoryTitle extends StatelessWidget {
  final String header;
  final List<WaterRecord> records;

  const ItemHistoryTitle({
    required this.header,
    required this.records,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          (record) => _item(context, record, records.last != record),
        ),
      ],
    );
  }

  Widget _item(
    BuildContext context,
    WaterRecord waterRecord,
    bool showUnderLine,
  ) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: GuDirect.space20,
          ),
          title: Text(
            '${waterRecord.value} ml',
            style: TextStyle(fontSize: GuDirect.fontSize18),
          ),
          subtitle: Text(
            '${waterRecord.date} ${waterRecord.timeStamp}',
            style: TextStyle(fontSize: GuDirect.fontSize16),
          ),
        ),
        if (showUnderLine) const Divider(),
      ],
    );
  }
}
