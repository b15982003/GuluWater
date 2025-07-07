import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gulu_water/service/share_database.dart';

final targetWaterProvider = StateNotifierProvider<TargetWaterProvider, double>(
  (ref) => TargetWaterProvider(0),
);

class TargetWaterProvider extends StateNotifier<double> {
  final ShareDataBase _shareDataBase = ShareDataBase();
  static const String TARGET_WATER_KEY = 'target_water_key';

  TargetWaterProvider(super._state) {
    _setup();
  }

  Future<void> _setup() async {
    double? targetWater = await _shareDataBase.getDouble(TARGET_WATER_KEY);
    if (targetWater == null) {
      await _shareDataBase.saveDouble(TARGET_WATER_KEY, 1200.0);
      targetWater = 1200.0;
    }
    state = targetWater;
  }

  Future<void> setTargetWater(double value) async {
    await _shareDataBase.saveDouble(TARGET_WATER_KEY, value);
    state = value;
  }
}
