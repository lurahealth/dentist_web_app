import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/models/AreaChartData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

FastLineSeries<ChartData, DateTime> getSplineChartDate(
    List<ChartData> splineData, Color color, double animationDuration) {
  return FastLineSeries<ChartData, DateTime>(
      name: "pH",
      dataSource: splineData,
      color: color,
      xValueMapper: (ChartData data, _) => data.timeStamp,
      yValueMapper: (ChartData data, _) => data.dataReading,
      animationDuration: animationDuration,
      width: 3);
}
