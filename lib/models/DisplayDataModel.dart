import 'package:lura_dentist_webapp/models/AreaChartData.dart';

class DisplayDataModel{
  DateTime startDate;
  DateTime endDate;
  List<ChartData> chartData;
  int minPh;
  int maxPh;
  int averagePh;

  DisplayDataModel({this.startDate, this.endDate, this.chartData, this.minPh,
      this.maxPh, this.averagePh});


}