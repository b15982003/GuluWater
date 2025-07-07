import 'package:flutter/material.dart';
import 'package:gulu_water/core/theme/gu_direct.dart';

Future<int?> guDialog({
  required BuildContext context,
  required String title,
  required String content,
}) async {
  var dialog = AlertDialog(
    title: title.isEmpty
        ? null
        : Text(title, style: TextStyle(fontSize: GuDirect.fontSize24)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title.isEmpty) const SizedBox(height: GuDirect.space16),
        Text(
          content,
          style: TextStyle(fontSize: GuDirect.fontSize20),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    actions: <Widget>[
      SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: _btnCancel(context)),
            const SizedBox(width: GuDirect.space16),
            Expanded(child: _btnConfirm(context)),
          ],
        ),
      ),
    ],
  );

  return showDialog<int>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(canPop: false, child: dialog);
    },
  );
}

Widget _btnCancel(BuildContext context) {
  return OutlinedButton(
    onPressed: () => Navigator.pop(context, -1),
    style: ButtonStyle(
      side: WidgetStateProperty.all(BorderSide(color: GuDirect.borderWaterBlue)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(GuDirect.radius28),
        ),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: GuDirect.space8),
      child: const Text(
        "取消",
        style: TextStyle(fontSize: GuDirect.fontSize20,
        color: GuDirect.textWaterBlue),
      ),
    ),
  );
}

Widget _btnConfirm(BuildContext context) {
  return FilledButton(
    onPressed: () => Navigator.pop(context, 1),
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
  );
}
