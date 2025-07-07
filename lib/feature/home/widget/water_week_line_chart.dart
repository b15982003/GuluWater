import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gulu_water/core/theme/gu_direct.dart';

class WaterWeekLineChart extends StatelessWidget {
  final List<FlSpot> data;
  final double target;
  final List<String> dates;

  const WaterWeekLineChart({
    super.key,
    required this.data,
    required this.target,
    required this.dates,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: GuDirect.backgroundWhite,
      margin: EdgeInsets.all(GuDirect.space8),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 20, top: 20, bottom: 20),
        child: LineChart(
          LineChartData(
            gridData: _buildFlGridData(),
            lineBarsData: [_buildLineChartBarData(context)],
            borderData: _buildFlBorderData(),
            titlesData: _buildFlTitlesData(),
          ),
        ),
      ),
    );
  }

  FlGridData _buildFlGridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      drawHorizontalLine: true,
      getDrawingHorizontalLine: (value) {
        var n = value == target
            ? FlLine(color: GuDirect.borderOrange, strokeWidth: 1)
            : defaultGridLine(value);
        return n;
      },
    );
  }

  LineChartBarData _buildLineChartBarData(BuildContext context) {
    return LineChartBarData(
      spots: data,
      color: GuDirect.borderWaterBlue,
      isCurved: true,
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [GuDirect.backgroundLightBlue, Theme.of(context).colorScheme.inversePrimary],
        ),
      ),
    );
  }

  FlBorderData _buildFlBorderData() {
    return FlBorderData(
      show: true,
      border: const Border(
        top: BorderSide.none,
        right: BorderSide.none,
        left: BorderSide(width: 1),
        bottom: BorderSide(width: 1),
      ),
    );
  }

  FlTitlesData _buildFlTitlesData() {
    return FlTitlesData(
      show: true,
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 50,
          minIncluded: false,
          maxIncluded: false,
          interval: 400,
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          minIncluded: false,
          interval: 1,
          getTitlesWidget: (value, meta) {
            return Text(dates[value.toInt()]);
          },
        ),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false, reservedSize: 40),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false, reservedSize: 30),
      ),
    );
  }
}
