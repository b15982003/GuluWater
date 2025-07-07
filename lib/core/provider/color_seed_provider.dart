import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gulu_water/core/theme/gu_direct.dart';
import 'package:gulu_water/feature/theme_setting/model/ThemeColor.dart';

import '../../service/share_database.dart';

final colorSeedProvider = StateNotifierProvider<ColorSeedProvider, Color>(
  (ref) => ColorSeedProvider(GuDirect.backgroundWaterBlue),
);

class ColorSeedProvider extends StateNotifier<Color> {
  final ShareDataBase _shareDataBase = ShareDataBase();
  static const String COLOR_SEED_KEY = 'color_seed_key';

  ColorSeedProvider(super._state) {
    _setup();
  }

  Future<void> _setup() async {
    String? colorSeed = await _shareDataBase.getString(COLOR_SEED_KEY);
    if (colorSeed == null) {
      await _shareDataBase.saveString(COLOR_SEED_KEY, 'backgroundWaterBlue');
      colorSeed = 'backgroundWaterBlue';
    }
    state = mapColorByKey(colorSeed);
  }

  Future<void> setThemeColor(String key) async {
    await _shareDataBase.saveString(COLOR_SEED_KEY, key);
    state = mapColorByKey(key);
  }

  List<ThemeColor> getThemeColorList() {
    return [
      ThemeColor(
        colorName: '主題經典深藍',
        colorValue: GuDirect.backgroundWaterBlue,
        colorIsSelected: state == GuDirect.backgroundWaterBlue,
        sharedPreferencesKey: 'backgroundWaterBlue',
      ),
      ThemeColor(
        colorName: '柔嫩夢幻的粉紅牛奶色',
        colorValue: GuDirect.ThemeUnicornMilk,
        colorIsSelected: state == GuDirect.ThemeUnicornMilk,
        sharedPreferencesKey: 'ThemeUnicornMilk',
      ),
      ThemeColor(
        colorName: '下雨天的大腦霧霧色',
        colorValue: GuDirect.ThemeBrainstormFog,
        colorIsSelected: state == GuDirect.ThemeBrainstormFog,
        sharedPreferencesKey: 'ThemeBrainstormFog',
      ),
      ThemeColor(
        colorName: '冥想到變果泥的酪梨綠',
        colorValue: GuDirect.ThemeAvocadoMeditation,
        colorIsSelected: state == GuDirect.ThemeAvocadoMeditation,
        sharedPreferencesKey: 'ThemeAvocadoMeditation',
      ),
      ThemeColor(
        colorName: '在北極講八卦的冰川藍',
        colorValue: GuDirect.ThemeGlacierGossip,
        colorIsSelected: state == GuDirect.ThemeGlacierGossip,
        sharedPreferencesKey: 'ThemeGlacierGossip',
      ),
      ThemeColor(
        colorName: '來自宇宙的奶泡拿鐵色',
        colorValue: GuDirect.ThemeCosmicLatte,
        colorIsSelected: state == GuDirect.ThemeCosmicLatte,
        sharedPreferencesKey: 'ThemeCosmicLatte',
      ),
      ThemeColor(
        colorName: '青蛙王子耳邊悄悄話綠',
        colorValue: GuDirect.ThemeFrogPrinceWhisper,
        colorIsSelected: state == GuDirect.ThemeFrogPrinceWhisper,
        sharedPreferencesKey: 'ThemeFrogPrinceWhisper',
      ),
      ThemeColor(
        colorName: '灑了眼淚的肥皂劇藍',
        colorValue: GuDirect.ThemeSoapOperaBlue,
        colorIsSelected: state == GuDirect.ThemeSoapOperaBlue,
        sharedPreferencesKey: 'ThemeSoapOperaBlue',
      ),
      ThemeColor(
        colorName: '驚嚇到噴出的葡萄汽水紫',
        colorValue: GuDirect.ThemeGrapeSodaPanic,
        colorIsSelected: state == GuDirect.ThemeGrapeSodaPanic,
        sharedPreferencesKey: 'ThemeGrapeSodaPanic',
      ),
      ThemeColor(
        colorName: '滑了一跤的香蕉黃',
        colorValue: GuDirect.ThemeBananaDrama,
        colorIsSelected: state == GuDirect.ThemeBananaDrama,
        sharedPreferencesKey: 'ThemeBananaDrama',
      ),
      ThemeColor(
        colorName: '日出時辣到哭的辣醬紅',
        colorValue: GuDirect.ThemeSrirachaSunrise,
        colorIsSelected: state == GuDirect.ThemeSrirachaSunrise,
        sharedPreferencesKey: 'ThemeSrirachaSunrise',
      ),
      ThemeColor(
        colorName: '聽貝殼告白的粉裸色',
        colorValue: GuDirect.ThemeSeashellConfession,
        colorIsSelected: state == GuDirect.ThemeSeashellConfession,
        sharedPreferencesKey: 'ThemeSeashellConfession',
      ),
      ThemeColor(
        colorName: '寫錯公式的粉筆奶油色',
        colorValue: GuDirect.ThemeChalkboardCream,
        colorIsSelected: state == GuDirect.ThemeChalkboardCream,
        sharedPreferencesKey: 'ThemeChalkboardCream',
      ),
      ThemeColor(
        colorName: '宅男喜歡的科技粉彩感',
        colorValue: GuDirect.ThemeTechnopastelVibe,
        colorIsSelected: state == GuDirect.ThemeTechnopastelVibe,
        sharedPreferencesKey: 'ThemeTechnopastelVibe',
      ),
      ThemeColor(
        colorName: '浮冰開會用的正式淺藍',
        colorValue: GuDirect.ThemeIcebergMeetingRoom,
        colorIsSelected: state == GuDirect.ThemeIcebergMeetingRoom,
        sharedPreferencesKey: 'ThemeIcebergMeetingRoom',
      ),
      ThemeColor(
        colorName: '來自外星茶館的抹茶綠',
        colorValue: GuDirect.ThemeAlienMatcha,
        colorIsSelected: state == GuDirect.ThemeAlienMatcha,
        sharedPreferencesKey: 'ThemeAlienMatcha',
      ),
      ThemeColor(
        colorName: '清新的仙人掌果昔綠',
        colorValue: GuDirect.ThemeCactusSmoothie,
        colorIsSelected: state == GuDirect.ThemeCactusSmoothie,
        sharedPreferencesKey: 'ThemeCactusSmoothie',
      ),
      ThemeColor(
        colorName: '爆炸蜜桃橘',
        colorValue: GuDirect.ThemePeachExplosion,
        colorIsSelected: state == GuDirect.ThemePeachExplosion,
        sharedPreferencesKey: 'ThemePeachExplosion',
      ),
      ThemeColor(
        colorName: '藍天爵士樂',
        colorValue: GuDirect.ThemeSkyJazz,
        colorIsSelected: state == GuDirect.ThemeSkyJazz,
        sharedPreferencesKey: 'ThemeSkyJazz',
      ),
      ThemeColor(
        colorName: '薰衣草風暴紫',
        colorValue: GuDirect.ThemeLavenderStorm,
        colorIsSelected: state == GuDirect.ThemeLavenderStorm,
        sharedPreferencesKey: 'ThemeLavenderStorm',
      ),
      ThemeColor(
        colorName: '海洋黃昏藍',
        colorValue: GuDirect.ThemeOceanDusk,
        colorIsSelected: state == GuDirect.ThemeOceanDusk,
        sharedPreferencesKey: 'ThemeOceanDusk',
      ),
      ThemeColor(
        colorName: '咖哩雲朵黃',
        colorValue: GuDirect.ThemeCurryCloud,
        colorIsSelected: state == GuDirect.ThemeCurryCloud,
        sharedPreferencesKey: 'ThemeCurryCloud',
      ),
      ThemeColor(
        colorName: '機器椰子綠',
        colorValue: GuDirect.ThemeRobotCoconut,
        colorIsSelected: state == GuDirect.ThemeRobotCoconut,
        sharedPreferencesKey: 'ThemeRobotCoconut',
      ),
      ThemeColor(
        colorName: '銀河芋頭紫',
        colorValue: GuDirect.ThemeGalaxyTaro,
        colorIsSelected: state == GuDirect.ThemeGalaxyTaro,
        sharedPreferencesKey: 'ThemeGalaxyTaro',
      ),
      ThemeColor(
        colorName: '加班芒果橘',
        colorValue: GuDirect.ThemeMangoOvertime,
        colorIsSelected: state == GuDirect.ThemeMangoOvertime,
        sharedPreferencesKey: 'ThemeMangoOvertime',
      ),
      ThemeColor(
        colorName: '鮪魚奶茶綠',
        colorValue: GuDirect.ThemeTunaMilkTea,
        colorIsSelected: state == GuDirect.ThemeTunaMilkTea,
        sharedPreferencesKey: 'ThemeTunaMilkTea',
      ),
      ThemeColor(
        colorName: '鍵盤珍奶棕',
        colorValue: GuDirect.ThemeBobaKeyboardBrown,
        colorIsSelected: state == GuDirect.ThemeBobaKeyboardBrown,
        sharedPreferencesKey: 'ThemeBobaKeyboardBrown',
      ),
      ThemeColor(
        colorName: '蠟筆夕陽橘',
        colorValue: GuDirect.ThemeCrayonSunset,
        colorIsSelected: state == GuDirect.ThemeCrayonSunset,
        sharedPreferencesKey: 'ThemeCrayonSunset',
      ),
      ThemeColor(
        colorName: '火龍果衝擊紅',
        colorValue: GuDirect.ThemeDragonfruitPunch,
        colorIsSelected: state == GuDirect.ThemeDragonfruitPunch,
        sharedPreferencesKey: 'ThemeDragonfruitPunch',
      ),
      ThemeColor(
        colorName: '慢吞吞薄荷藍',
        colorValue: GuDirect.ThemeMintSloth,
        colorIsSelected: state == GuDirect.ThemeMintSloth,
        sharedPreferencesKey: 'ThemeMintSloth',
      ),
      ThemeColor(
        colorName: '布丁雷擊黃',
        colorValue: GuDirect.ThemePuddingThunder,
        colorIsSelected: state == GuDirect.ThemePuddingThunder,
        sharedPreferencesKey: 'ThemePuddingThunder',
      ),
    ];
  }

  Color mapColorByKey(String colorKey) {
    switch (colorKey) {
      case 'ThemeUnicornMilk':
        return GuDirect.ThemeUnicornMilk;
      case 'ThemeBrainstormFog':
        return GuDirect.ThemeBrainstormFog;
      case 'ThemeAvocadoMeditation':
        return GuDirect.ThemeAvocadoMeditation;
      case 'ThemeGlacierGossip':
        return GuDirect.ThemeGlacierGossip;
      case 'ThemeCosmicLatte':
        return GuDirect.ThemeCosmicLatte;
      case 'ThemeFrogPrinceWhisper':
        return GuDirect.ThemeFrogPrinceWhisper;
      case 'ThemeSoapOperaBlue':
        return GuDirect.ThemeSoapOperaBlue;
      case 'ThemeGrapeSodaPanic':
        return GuDirect.ThemeGrapeSodaPanic;
      case 'ThemeBananaDrama':
        return GuDirect.ThemeBananaDrama;
      case 'ThemeSrirachaSunrise':
        return GuDirect.ThemeSrirachaSunrise;
      case 'ThemeSeashellConfession':
        return GuDirect.ThemeSeashellConfession;
      case 'ThemeChalkboardCream':
        return GuDirect.ThemeChalkboardCream;
      case 'ThemeTechnopastelVibe':
        return GuDirect.ThemeTechnopastelVibe;
      case 'ThemeIcebergMeetingRoom':
        return GuDirect.ThemeIcebergMeetingRoom;
      case 'ThemeAlienMatcha':
        return GuDirect.ThemeAlienMatcha;
      case 'ThemeCactusSmoothie':
        return GuDirect.ThemeCactusSmoothie;
      case 'ThemePeachExplosion':
        return GuDirect.ThemePeachExplosion;
      case 'ThemeSkyJazz':
        return GuDirect.ThemeSkyJazz;
      case 'ThemeLavenderStorm':
        return GuDirect.ThemeLavenderStorm;
      case 'ThemeOceanDusk':
        return GuDirect.ThemeOceanDusk;
      case 'ThemeCurryCloud':
        return GuDirect.ThemeCurryCloud;
      case 'ThemeRobotCoconut':
        return GuDirect.ThemeRobotCoconut;
      case 'ThemeGalaxyTaro':
        return GuDirect.ThemeGalaxyTaro;
      case 'ThemeMangoOvertime':
        return GuDirect.ThemeMangoOvertime;
      case 'ThemeTunaMilkTea':
        return GuDirect.ThemeTunaMilkTea;
      case 'ThemeBobaKeyboardBrown':
        return GuDirect.ThemeBobaKeyboardBrown;
      case 'ThemeCrayonSunset':
        return GuDirect.ThemeCrayonSunset;
      case 'ThemeDragonfruitPunch':
        return GuDirect.ThemeDragonfruitPunch;
      case 'ThemeMintSloth':
        return GuDirect.ThemeMintSloth;
      case 'ThemePuddingThunder':
        return GuDirect.ThemePuddingThunder;
      default:
        return GuDirect.backgroundWaterBlue;
    }
  }
}
