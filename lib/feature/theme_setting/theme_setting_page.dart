import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gulu_water/core/theme/gu_direct.dart';
import 'package:gulu_water/feature/theme_setting/model/ThemeColor.dart';
import 'package:gulu_water/feature/theme_setting/widget/Item_theme_title.dart';

import '../../core/provider/color_seed_provider.dart';
import '../../core/widget/gu_progress.dart';

class ThemeSettingPage extends ConsumerWidget {
  late final ColorSeedProvider _colorSeedProvider;

  final List<ThemeColor> _themeColorItems = [];

  ThemeSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _colorSeedProvider = ref.watch(colorSeedProvider.notifier);
    _getThemeColorList();

    var appBar = AppBar(title: const Text('選擇主題'));

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: GuDirect.space20,
          horizontal: GuDirect.space20,
        ),
        child: Column(
          children: [
            _buildUI(context),
            // _btnSave(context, _colorSeedProvider),
            // SizedBox(height: GuDirect.space16),
          ],
        ),
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Expanded(
      child: SafeArea(
        child: ListView.builder(
          itemCount: _themeColorItems.length,
          itemBuilder: (context, index) {
            return itemThemeTitle(
              context: context,
              data: _themeColorItems[index],
              onClick: () {
                _colorSeedProvider.setThemeColor(
                  _themeColorItems[index].sharedPreferencesKey,
                );
                _getThemeColorList();
              },
            );
          },
        ),
      ),
    );
  }

  void _getThemeColorList() {
    _themeColorItems.clear();
    _themeColorItems.addAll(
      _colorSeedProvider.getThemeColorList(GuDirect.backgroundWaterBlue),
    );
  }
}
