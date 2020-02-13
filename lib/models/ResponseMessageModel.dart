import 'package:lura_dentist_webapp/models/AreaChartData.dart';
import 'package:lura_dentist_webapp/models/DataModel.dart';

class ResponseMessageModel {
  int rowCount;
  List<AreaChartData> rows;

  ResponseMessageModel(this.rowCount, this.rows);

  factory ResponseMessageModel.fromJson(Map<String, dynamic> json) {
    return ResponseMessageModel(
        json["rowCount"],
        json["rows"].forEach((item) => AreaChartData.fromJsonAPI(item))
    );
  }
}
