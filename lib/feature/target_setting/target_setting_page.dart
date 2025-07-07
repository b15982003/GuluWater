import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gulu_water/core/theme/gu_direct.dart';

import '../../core/provider/target_water_provider.dart';
import '../../core/widget/gu_progress.dart';

class TargetSettingPage extends ConsumerWidget {
  final ValueNotifier<double> _itemName = ValueNotifier(0.0);
  final ValueNotifier<int> _selectedItem = ValueNotifier(-1);

  final List<double> dropDownItems = [
    400,
    800,
    1200,
    1600,
    2000,
    2400,
    2800,
    3200,
    3600,
    4000,
  ];

  TargetSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TargetWaterProvider _targetWaterProvider = ref.read(
      targetWaterProvider.notifier,
    );

    _itemName.value = ref.watch(targetWaterProvider);
    _selectedItem.value = dropDownItems.indexOf(_itemName.value);

    var appBar = AppBar(title: const Text('目標設定'));

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: GuDirect.space20,
          horizontal: GuDirect.space20,
        ),
        child: _buildUI(context, _targetWaterProvider),
      ),
    );
  }

  Widget _buildUI(
    BuildContext context,
    TargetWaterProvider targetWaterProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: GuDirect.space32),
          child: const Text(
            '選擇你每日的飲水目標',
            style: TextStyle(fontSize: GuDirect.fontSize24),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: ValueListenableBuilder<int>(
              valueListenable: _selectedItem,
              builder: _dropdownButtonBuilder,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: _btnSave(context, targetWaterProvider),
        ),
        SizedBox(height: GuDirect.space16),
      ],
    );
  }

  Widget _btnSave(
    BuildContext context,
    TargetWaterProvider targetWaterProvider,
  ) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () async {
          targetWaterProvider.setTargetWater(
            dropDownItems[_selectedItem.value],
          );
          final result = await showLoading(context);
          if (result && context.mounted) {
            Navigator.pop(context);
          }
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            GuDirect.backgroundWaterBlue,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(GuDirect.radius28),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: GuDirect.space8),
          child: const Text(
            "儲存",
            style: TextStyle(fontSize: GuDirect.fontSize20),
          ),
        ),
      ),
    );
  }

  Widget _dropdownButtonBuilder(
    BuildContext context,
    int selectedItem,
    Widget? child,
  ) {
    final dropdownButton = DropdownButton(
      alignment: Alignment.center,
      items: _getDropDownItems(),
      onChanged: (dynamic value) => {_selectedItem.value = value as int},
      hint: const Text(
        '請選擇目標',
        style: TextStyle(fontSize: GuDirect.fontSize28),
      ),
      value: selectedItem < 0 ? null : selectedItem,
    );

    return dropdownButton;
  }

  List<DropdownMenuItem> _getDropDownItems() {
    var items = <DropdownMenuItem>[];
    for (var i = 0; i < dropDownItems.length; i++) {
      items.add(
        DropdownMenuItem(
          alignment: Alignment.center,
          value: i.toInt(),
          child: Text(
            dropDownItems[i].toInt().toString(),
            style: const TextStyle(fontSize: GuDirect.fontSize20),
          ),
        ),
      );
    }
    return items;
  }
}
