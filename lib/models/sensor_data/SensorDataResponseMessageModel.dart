import 'package:lura_dentist_webapp/models/AreaChartData.dart';

class SensorDataResponseMessageModel {
  int rowCount;
  int min;
  int max;
  int average;
  List<ChartData> rows;

  SensorDataResponseMessageModel(this.rowCount, this.min, this.max,
                                 this.average, this.rows);

  factory SensorDataResponseMessageModel.fromJson(Map<String, dynamic> json) {
    var data = json["rows"] as List;
    return SensorDataResponseMessageModel(
        json["rowCount"],
        json["min"],
        json["max"],
        json["average"],
        data.map((i) => ChartData.fromJsonAPI(i)).toList()
    );
  }
}
