import 'dart:ui';

class ThemeColor {
  static const String ColorName = 'color_name';
  static const String ColorValue = 'color_value';
  static const String ColorIsSelected = 'color_is_selected';
  static const String SharedPreferencesKey = 'shared_preferences_key';

  final String colorName;
  final Color colorValue;
  final bool colorIsSelected;
  final String sharedPreferencesKey;

  ThemeColor({
    required this.colorName,
    required this.colorValue,
    required this.colorIsSelected,
    this.sharedPreferencesKey = SharedPreferencesKey,
  });

  Map<String, dynamic> toMap() {
    return {
      ColorName: colorName,
      ColorValue: colorValue,
      ColorIsSelected: colorIsSelected,
      SharedPreferencesKey: sharedPreferencesKey,
    };
  }
}