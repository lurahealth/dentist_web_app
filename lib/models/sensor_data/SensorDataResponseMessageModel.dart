import 'package:lura_dentist_webapp/models/AreaChartData.dart';

class SensorDataResponseMessageModel {
  int rowCount;
  int min;
  int max;
  int average;
  List<AreaChartData> rows;

  SensorDataResponseMessageModel(this.rowCount, this.min, this.max, this.average,
      this.rows);

  factory SensorDataResponseMessageModel.fromJson(Map<String, dynamic> json) {
    return SensorDataResponseMessageModel(
        json["rowCount"],
        json["min"],
        json["max"],
        json["average"],
        json["rows"].forEach((item) => AreaChartData.fromJsonAPI(item))
    );
  }
}
