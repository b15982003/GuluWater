import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/theme/gu_direct.dart';

Widget waterTodayProgress(
  BuildContext context,
  int targetWater,
  int toDayTotalWaterML,
) {
  final percent = (toDayTotalWaterML / targetWater).clamp(0.0, 1.0);
  return CircularPercentIndicator(
    progressColor: Theme.of(context).colorScheme.inversePrimary,
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
        '$toDayTotalWaterML/${targetWater}ml',
        style: TextStyle(fontSize: GuDirect.fontSize16),
      ),
    ),
  );
}
