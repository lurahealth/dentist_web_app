

import 'package:lura_dentist_webapp/utils/StringUtils.dart';

class DataModel{
  final num pH;
  final num battery;
  final num temperature;
  final num connectionTime;
  final DateTime timeStamp;
  final String notes;
  final String deviceId;
  final bool uploaded;

  DataModel(this.pH,
            this.battery,
            this.temperature,
            this.connectionTime,
            this.timeStamp,
            this.notes,
            this.deviceId,
            this.uploaded);

  Map<String, dynamic> toMap(){
    return {
      PH: pH,
      BATTERY: battery,
      TEMPERATURE: temperature,
      CONNETION_TIME: connectionTime,
      TIME_STAMP: timeStamp.millisecondsSinceEpoch,
      NOTES: notes,
      DEVICE_ID: deviceId,
      UPLOADED: uploaded? 1:0 // 1 if uploaded, else 0
    };
  }

  String toString(){
    return "TimeStamp: ${timeStamp.toIso8601String()} pH: $pH Voltage: $battery"
           "Temparature: $temperature Device id: $deviceId";
  }

  factory DataModel.fromMap(Map<String, dynamic> map){
    return DataModel(
      map[PH],
      map[BATTERY],
      map[TEMPERATURE],
      map[CONNETION_TIME],
      DateTime.parse(map[TIME_STAMP]).toLocal(),
      map[NOTES],
      map[DEVICE_ID],
      false
    );
  }

  factory DataModel.fromRawDataString(String data, String notes,
                                      String deviceName, DateTime nowUTC){
    List<String> readings = data.split(",");
    return DataModel(
        double.parse(readings[0]),
        double.parse(readings[2]),
        double.parse(readings[1]),
        (readings.length > 3)? double.parse(readings[3]):null,
        nowUTC,
        notes,
        deviceName,
        true
    );
  }
}