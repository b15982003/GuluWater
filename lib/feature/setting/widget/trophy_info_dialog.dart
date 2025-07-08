import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gulu_water/core/theme/gu_direct.dart';

Future trophyInfoDialog({
  required BuildContext context,
  required List<String> imgTrophy,
}) {
  var dialog = AlertDialog(
    title: const Text('獎杯資訊', textAlign: TextAlign.center),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _description(),
        _trophyList(context: context, imgTrophy: imgTrophy),
      ],
    ),
  );

  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return PopScope(canPop: true, child: dialog);
    },
  );
}

Widget _description() {
  return Text('本週達成率會獲得不同的獎盃', style: TextStyle(fontSize: GuDirect.fontSize18));
}

Widget _trophyList({
  required BuildContext context,
  required List<String> imgTrophy,
}) {
  return SizedBox(
    height: 300,
    width: MediaQuery.sizeOf(context).width,
    child: ListView.builder(
      itemCount: imgTrophy.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return _trophyItem(completeDay: index, imgTrophy: imgTrophy[index]);
      },
    ),
  );
}

Widget _trophyItem({required int completeDay, required String imgTrophy}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: GuDirect.space8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(imgTrophy, width: GuDirect.iconSize56, height: GuDirect.iconSize56),
        const SizedBox(width: GuDirect.space16),
        Text(
          '$completeDay 天達成率',
          style: TextStyle(fontSize: GuDirect.fontSize20),
        ),
      ],
    ),
  );
}
