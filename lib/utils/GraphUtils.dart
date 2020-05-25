import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/models/AreaChartData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

HiloSeries<ChartData, DateTime> getHealthyData(
    List<ChartData> splineData, Color color, double animationDuration) {
  return HiloSeries<ChartData, DateTime>(
      name: "pH",
      dataSource: splineData,
      color: color,
      xValueMapper: (ChartData data, _) => data.timeStamp,
      highValueMapper: (ChartData data, _) =>
                data.dataReading > 5.5 ? data.dataReading : null,
      lowValueMapper: (ChartData data, _) => 5.51,
      animationDuration: animationDuration,
      borderWidth: 2
  );
}

HiloSeries<ChartData, DateTime> getUnhealthyData(
    List<ChartData> splineData, Color color, double animationDuration) {
  return HiloSeries<ChartData, DateTime>(
      name: "pH",
      dataSource: splineData,
      color: color,
      xValueMapper: (ChartData data, _) => data.timeStamp,
      lowValueMapper: (ChartData data, _) =>
                data.dataReading <= 5.5 ? data.dataReading : null,
      highValueMapper: (ChartData data, _) => 5.49,
      animationDuration: animationDuration,
      borderWidth: 2
  );
}

