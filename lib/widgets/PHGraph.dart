import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/GraphDataProvider.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';

import 'package:lura_dentist_webapp/utils/GraphUtils.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PHGraph extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final GraphDataProvider provider = Provider.of<GraphDataProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: LURA_BLUE,
        borderRadius: BorderRadius.circular(16)
      ),
      child: SfCartesianChart(
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
        tooltipBehavior: TooltipBehavior(
          enable: true,

        ),
        series: <ChartSeries>[
          getSplineChartDate(
              provider.displaySegments[provider.currentSegment].chartData, Colors.white, 500), // half a second animation
        ],
        selectionType: SelectionType.point,
      ),
    );
  }
}
