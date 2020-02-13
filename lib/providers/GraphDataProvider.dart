import 'package:flutter/cupertino.dart';
import 'package:lura_dentist_webapp/utils/RestEndpoints.dart';

class GraphDataProvider with ChangeNotifier{
  static DateTime now = DateTime.now();
  DateTime sensorDataFromDate = now.subtract(Duration(days: 7));
  DateTime sensorDataToDate = now;
  String deviceId = "Lura_Health_Rakshak_1";

  bool error = false;
  String errorMessage = "";

  bool dataLoaded = false;
  bool loadingData;

  void getData(){
    if(!dataLoaded){
      dataLoaded = true;
      loadingData = true;
      //notifyListeners();

      getPastSensorReadings(
          deviceId, sensorDataFromDate, sensorDataToDate)
          .then(getDataSuccess, onError: getDataFailed);
    }
  }

  void getDataSuccess(result){
    print("Get data success ${result.toString()}");
    loadingData = false;
    notifyListeners();
  }

  void getDataFailed(error){
    print("Error getting sensor data: ${error.toString()}");
    loadingData = false;
    error = true;
    errorMessage = error.toString();
    notifyListeners();
  }
}