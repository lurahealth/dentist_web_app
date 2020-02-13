import 'package:flutter/cupertino.dart';
import 'package:lura_dentist_webapp/models/ResponseMessageModel.dart';
import 'package:lura_dentist_webapp/models/GetDataResponseModel.dart';
import 'package:lura_dentist_webapp/services/NetworkCommon.dart';
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

  void getDataSuccess(r){
    Map<String, dynamic> result = new NetworkCommon().decodeResp(r);
    print("Get data success");
//    print("Get data success ${result}");
    GetDataResponseModel response = GetDataResponseModel.fromJson(result);
    print("Row count: ${response.responseMessageModel.rowCount}");
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