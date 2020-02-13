import 'package:lura_dentist_webapp/services/NetworkCommon.dart';

Future getPastSensorReadings(String deviceId,
                             DateTime from, DateTime to) async {

  print("Getting past sensor data DeviceId: $deviceId "
      "From date: ${from.toString()} To date: ${to.toString()}");

  const String URL =
      "https://vlvwmemd96.execute-api.us-east-1.amazonaws.com/v1/sensordata";

  Map<String, String> queryParameters = {"deviceId": deviceId};

  if (from != null && to != null) {
    queryParameters
        .addAll({"from": from.toString(), "to": to.toString()});
  }

  return await new NetworkCommon()
      .dio
      .get(URL, queryParameters: queryParameters);
}