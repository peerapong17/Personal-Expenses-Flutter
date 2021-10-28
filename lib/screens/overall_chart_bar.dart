import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OverallChartBar extends StatelessWidget {
  final List<ChartData> chartData;

  const OverallChartBar(this.chartData);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Overall Chart"),
          backgroundColor: Colors.pink,
          centerTitle: true,
        ),
        body: SfCartesianChart(
          title: ChartTitle(text: 'Your expenses in the last 7 days - 2021'),
          legend: Legend(
              isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
          primaryXAxis: CategoryAxis(),
          series: <CartesianSeries>[
            ColumnSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, index) => data.day,
              yValueMapper: (ChartData data, index) => data.amount,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              animationDuration: 1000,
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
            ),
          ],
        ),
      ),
    );
  }
}
