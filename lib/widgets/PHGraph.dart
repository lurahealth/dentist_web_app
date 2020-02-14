import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/GraphDataProvider.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:lura_dentist_webapp/utils/GraphUtils.dart';

class PHGraph extends StatelessWidget {
  final GraphDataProvider provider;

  PHGraph(this.provider);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SfCartesianChart(
          plotAreaBorderColor: LURA_BLUE,
          borderColor: LURA_BLUE,
          backgroundColor: LURA_BLUE,
          // Initialize category axis
          primaryXAxis: DateTimeAxis(
              axisLine: AxisLine(color: LURA_BLUE),
              labelStyle: ChartTextStyle(color: Colors.white),
              majorGridLines: MajorGridLines(color: LURA_BLUE)),
          primaryYAxis: NumericAxis(
            majorGridLines: MajorGridLines(color: LURA_BLUE),
            labelStyle: ChartTextStyle(color: Colors.white),
            axisLine: AxisLine(color: LURA_BLUE),
          ),
          crosshairBehavior: CrosshairBehavior(
            lineColor: Colors.white,
            enable: true,
            activationMode: ActivationMode.singleTap,
          ),
          series: <ChartSeries>[
            getAreaChartDate(
                provider.pHData, Colors.white, 500), // half a second animation
          ],
          selectionType: SelectionType.point,
        ),
      ],
    );
  }
}
