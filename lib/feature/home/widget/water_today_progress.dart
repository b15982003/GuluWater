import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/theme/gu_direct.dart';

Widget waterTodayProgress(BuildContext context, int toDayTotalWaterML) {
  final percent = toDayTotalWaterML / 8000;
  return CircularPercentIndicator(
    progressColor: GuDirect.backgroundWaterBlue,
    animation: true,
    lineWidth: 26,
    percent: percent,
    circularStrokeCap: CircularStrokeCap.round,
    center: Text(
      '${(percent * 100).toStringAsFixed(0)}%',
      style: TextStyle(fontSize: GuDirect.fontSize28),
    ),
    radius: MediaQuery.of(context).size.width / 4,
    footer: Padding(
      padding: const EdgeInsets.only(top: GuDirect.space16),
      child: Text(
        '${toDayTotalWaterML}/${8000}ml',
        style: TextStyle(fontSize: GuDirect.fontSize16),
      ),
    ),
  );
}