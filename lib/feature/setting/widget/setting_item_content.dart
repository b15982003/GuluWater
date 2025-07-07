import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/gu_direct.dart';

Widget settingItemContent({
  required BuildContext context,
  required String title,
  required Function() press,
  String content = '',
  bool showUnderLine = true,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      left: GuDirect.space8,
      top: GuDirect.space12,
      right: GuDirect.space12,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontSize: GuDirect.fontSize16)),
            if (content.isNotEmpty)
              Text(content, style: TextStyle(fontSize: GuDirect.fontSize16)),
            if (content.isEmpty)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: GuDirect.iconSize20,
                color: GuDirect.borderDarkGray,
              ),
          ],
        ),
        SizedBox(height: GuDirect.space12),
        if (showUnderLine) Divider(color: GuDirect.borderDarkGray),
      ],
    ),
  );
}
