import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/models/AreaChartData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

SplineSeries<AreaChartData, DateTime> getAreaChartDate(
    List<AreaChartData> splineData, Color color, double animationDuration) {
  return SplineSeries<AreaChartData, DateTime>(
      dataSource: splineData,
      color: color,
      xValueMapper: (AreaChartData data, _) => data.timeStamp,
      yValueMapper: (AreaChartData data, _) => data.dataReading,
      animationDuration: animationDuration,
      width: 5);
}
