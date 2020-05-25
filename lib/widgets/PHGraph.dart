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
            majorGridLines: MajorGridLines(
                color: LURA_DARK_BLUE,
                width: 0.5),
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(
              //color: LURA_BLUE,
              color: LURA_DARK_BLUE,
              width: 0.5
          ),

//          plotBands: <PlotBand>[
//            PlotBand(
//              isVisible: true,
//              start: 5.49,
//              end: 5.51,
//              color: Colors.red[700],
//            )
//          ],
          labelStyle: ChartTextStyle(color: Colors.white),
          axisLine: AxisLine(color: LURA_DARK_BLUE),
          minimum: 2.0,
        ),
        crosshairBehavior: CrosshairBehavior(
          lineColor: Colors.grey,
          enable: false,
          activationMode: ActivationMode.doubleTap,
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,

        ),
        series: <ChartSeries>[
          getHealthyData(
              provider.displaySegments[provider.currentSegment].chartData, Colors.white, 100
          ),
          getUnhealthyData(
              provider.displaySegments[provider.currentSegment].chartData, LURA_ORANGE, 100
          ),

        ],
        selectionType: SelectionType.point,

        // Zooming
        zoomPanBehavior: ZoomPanBehavior (
          enableMouseWheelZooming: true,
          enablePanning: true,
          zoomMode: ZoomMode.x
        ),
      ),
    );
  }
}
