import 'package:flutter/cupertino.dart';

import '../../../core/theme/gu_direct.dart';

Widget settingItemTitle({required BuildContext context, required String title}) {
  return Container(
    width: double.infinity,
    alignment: Alignment.centerLeft,
    child: Text(
      title,
      style: TextStyle(fontSize: GuDirect.fontSize20),
      textAlign: TextAlign.start,
    ),
  );
}