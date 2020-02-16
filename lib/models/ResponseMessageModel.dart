import 'package:lura_dentist_webapp/models/AreaChartData.dart';

class ResponseMessageModel {
  int rowCount;
  int min;
  int max;
  int average;
  List<AreaChartData> rows;

  ResponseMessageModel(this.rowCount, this.min, this.max, this.average,
      this.rows);

  factory ResponseMessageModel.fromJson(Map<String, dynamic> json) {
    return ResponseMessageModel(
        json["rowCount"],
        json["min"],
        json["max"],
        json["average"],
        json["rows"].forEach((item) => AreaChartData.fromJsonAPI(item))
    );
  }
}
