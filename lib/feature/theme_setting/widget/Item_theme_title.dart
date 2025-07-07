import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gulu_water/core/theme/gu_direct.dart';
import 'package:gulu_water/feature/theme_setting/model/ThemeColor.dart';

Widget itemThemeTitle({
  required BuildContext context,
  required ThemeColor data,
  required Function() onClick,
}) {
  return GestureDetector(
    onTap: () => onClick(),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: data.colorValue,
        radius: GuDirect.radius12,
      ),
      title: Text(
        data.colorName.toString(),
        style: TextStyle(color: data.colorValue),
      ),
      trailing: data.colorIsSelected
          ? Icon(Icons.check, color: GuDirect.backgroundBlack)
          : null,
    ),
  );
}
