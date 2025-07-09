import 'package:flutter/material.dart';

import '../theme/gu_direct.dart';

Future<bool> showLoading(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(color: GuDirect.backgroundWhite),
      );
    },
  );

  await Future.delayed(const Duration(milliseconds: 800));

  if (context.mounted) {
    Navigator.pop(context);
  }

  return true;
}