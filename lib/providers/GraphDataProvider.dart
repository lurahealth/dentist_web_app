import 'package:flutter/cupertino.dart';
import 'package:lura_dentist_webapp/models/AreaChartData.dart';
import 'package:lura_dentist_webapp/models/DisplayDataModel.dart';
import 'package:lura_dentist_webapp/models/patient/PatientModel.dart';
import 'package:lura_dentist_webapp/models/sensor_data/GetSensorDataResponseModel.dart';
import 'package:lura_dentist_webapp/models/sensor_data/SensorDataResponseMessageModel.dart';
import 'package:lura_dentist_webapp/services/NetworkCommon.dart';
import 'package:lura_dentist_webapp/utils/RestEndpoints.dart';
import 'dart:math';

class GraphDataProvider with ChangeNotifier{

  final PatientModel currentPatient;
  GraphDataProvider(this.currentPatient);

  DateTime sensorDataFromDate;
  DateTime sensorDataToDate;
  List<ChartData> pHData = <ChartData>[];
  List<DisplayDataModel> displaySegments = [];
  int currentSegment = 0;
  int animationDuration = 500;
  int dataPointsPerSegment = 100;
  int timesOverValue = 7;
  int timesUnderValue = 4;

  bool error = false;
  String errorMessage = "";

  bool dataLoaded = false;
  bool loadingData = true;

  void getSensorDataFromCloud(){
    if(!dataLoaded){
      dataLoaded = true;

      if(!loadingData){
        loadingData = true;
        notifyListeners();
      }

      getPastSensorReadings(
          currentPatient.patientEmail, sensorDataFromDate, sensorDataToDate)
          .then(getDataSuccess, onError: getDataFailed);
    }
  }

  void getDataSuccess(r){
    Map<String, dynamic> result = new NetworkCommon().decodeResp(r);
    print("Get data success");
    GetSensorDataResponseModel response = GetSensorDataResponseModel.fromJson(result);
    SensorDataResponseMessageModel responseMessage = response.responseMessageModel;
    pHData = responseMessage.rows;
    if(pHData.length > 0) {
      splitDataIntoSegments(dataPointsPerSegment);
    }
    loadingData = false;
    print("Row count: ${pHData.length}");
    notifyListeners();
  }

  void splitDataIntoSegments(int segmentCount){
    int rowCount = pHData.length;
    int numberOfSegments = (rowCount/segmentCount).ceil();
    for(int i =1;i<= numberOfSegments;i++){
      print("Segment count $i");
      int startRange = (i-1) * segmentCount;
      int endRange = i * segmentCount;
      if(endRange > pHData.length){
        endRange = pHData.length -1;
      }
      setDataSegment(pHData.getRange(startRange, endRange).toList());
    }
  }

  void setDataSegment(List<ChartData> segment){
    print("Segment count ${segment.length}");

    List<num> phValues = segment.map((dataPoint) => dataPoint.dataReading).toList();
    int timesOver = 0;
    int timesUnder = 0;
    phValues.forEach((value) {
      if (value > timesOverValue) {
        timesOver++;
      } else if (value < timesUnderValue) {
        timesUnder--;
      }
    });

    int average = ((phValues.reduce((first, next) => first+next))/(segment.length)).round();
    int minPh = phValues.reduce(min).round();
    int maxPh = phValues.reduce(max).round();

    DisplayDataModel dataModel = DisplayDataModel(
      startDate: segment.first.timeStamp,
      endDate: segment.last.timeStamp,
      chartData: segment,
      maxPh: maxPh,
      minPh: minPh,
      averagePh: average,
      timesOver: timesOver,
      timesUnder: timesUnder
    );

    displaySegments.add(dataModel);
  }

  void showLastWeeksData(){
    if(currentSegment > 0){
      currentSegment = currentSegment -1;
      notifyListeners();
    }
  }

  void showNextWeeksData(){
    if(currentSegment != displaySegments.length -1){
      currentSegment = currentSegment + 1;
      notifyListeners();
    }
  }

  void getDataFailed(error){
    print("Error getting sensor data: ${error.toString()}");
    loadingData = false;
    error = true;
    errorMessage = error.toString();
    notifyListeners();
  }

  void clearDates() {
    sensorDataFromDate = null;
    sensorDataToDate = null;
    dataLoaded = false;
    getSensorDataFromCloud();
  }
}