import 'package:lura_dentist_webapp/utils/StringUtils.dart';

class ChartData{
  num dataReading;
  DateTime timeStamp;

  ChartData(this.dataReading, this.timeStamp);

  factory ChartData.fromLiveData(DateTime timeStamp, double dataReading){
    return ChartData(dataReading, timeStamp);
  }

  factory ChartData.fromDatabase(int timeInMillSeconds, double dataReading){
    return ChartData(dataReading,
                      DateTime.fromMillisecondsSinceEpoch(timeInMillSeconds));
  }

  factory ChartData.fromJsonAPI(Map<String, dynamic> map) {
    return ChartData(map["ph"], DateTime.parse(map[TIME_STAMP]).toLocal(),);
  }
}