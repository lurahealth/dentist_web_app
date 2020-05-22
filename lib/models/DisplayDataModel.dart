import 'package:lura_dentist_webapp/models/AreaChartData.dart';

class DisplayDataModel{
  DateTime startDate;
  DateTime endDate;
  List<ChartData> chartData;
  double minPh;
  double maxPh;
  double averagePh;
  int timesOver;
  int timesUnder;
  double percentTimeUnder;
  double percentTimeOver;

  DisplayDataModel({this.startDate, this.endDate, this.chartData, this.minPh,
      this.maxPh, this.averagePh, this.timesOver, this.timesUnder,
      this.percentTimeUnder, this.percentTimeOver});


}