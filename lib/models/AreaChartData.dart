import 'package:lura_dentist_webapp/utils/StringUtils.dart';

class AreaChartData{
  num dataReading;
  DateTime timeStamp;

  AreaChartData(this.dataReading, this.timeStamp);

  factory AreaChartData.fromLiveData(DateTime timeStamp, double dataReading){
    return AreaChartData(dataReading, timeStamp);
  }

  factory AreaChartData.fromDatabase(int timeInMillSeconds, double dataReading){
    return AreaChartData(dataReading,
                      DateTime.fromMillisecondsSinceEpoch(timeInMillSeconds));
  }

  factory AreaChartData.fromJsonAPI(Map<String, dynamic> map) {
    return AreaChartData(map["ph"], DateTime.parse(map[TIME_STAMP]).toLocal(),);
  }
}