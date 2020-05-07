import 'package:flutter/cupertino.dart';
import 'package:lura_dentist_webapp/models/AreaChartData.dart';
import 'package:lura_dentist_webapp/models/patient/PatientModel.dart';
import 'package:lura_dentist_webapp/models/sensor_data/GetSensorDataResponseModel.dart';
import 'package:lura_dentist_webapp/models/sensor_data/SensorDataResponseMessageModel.dart';
import 'package:lura_dentist_webapp/services/NetworkCommon.dart';
import 'package:lura_dentist_webapp/utils/RestEndpoints.dart';

class GraphDataProvider with ChangeNotifier{

  final PatientModel currentPatient;
  GraphDataProvider(this.currentPatient);

  static DateTime now = DateTime.now();
  DateTime sensorDataFromDate = now.subtract(Duration(days: 7));
  DateTime sensorDataToDate = now;
  String deviceId = "Lura_Health_Rakshak_1";
  List<AreaChartData> pHData = <AreaChartData>[];
  int animationDuration = 500;
  int minPh;
  int maxPh;
  int averagePh;

  bool error = false;
  String errorMessage = "";

  bool dataLoaded = false;
  bool loadingData;

  void getData(){
    if(!dataLoaded){
      dataLoaded = true;
      loadingData = true;
      notifyListeners();

      getPastSensorReadings(
          deviceId, sensorDataFromDate, sensorDataToDate)
          .then(getDataSuccess, onError: getDataFailed);
    }
  }

  void getDataSuccess(r){
    Map<String, dynamic> result = new NetworkCommon().decodeResp(r);
    print("Get data success");
    GetSensorDataResponseModel response = GetSensorDataResponseModel.fromJson(result);
    SensorDataResponseMessageModel responseMessage = response.responseMessageModel;
    print("Row count: ${response.responseMessageModel.rowCount}");
    pHData = responseMessage.rows;
    minPh = responseMessage.min;
    maxPh = responseMessage.max;
    averagePh = responseMessage.average;
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