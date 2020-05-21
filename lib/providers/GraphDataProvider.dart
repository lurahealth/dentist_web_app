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
  int animationDuration = 300;
  // Seems like for the pseudo-generated demo data, 98 is the right amount of
  // data points per segment for "one day". Should be 96. One week is 686 for
  // psuedo-generated data, but should be 672 irl
  int dataPointsPerSegment = 686;
  double timesOverValue = 5.5;
  double timesUnderValue = 5.5;

  bool error = false;
  String errorMessage = "";

  bool clearDatesSelected = false;
  bool dataLoaded = false;
  bool loadingData = true;
  bool showCustomDateRange = false;

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
    if(pHData.length > 0 && showCustomDateRange == false) {
      splitDataIntoSegments(dataPointsPerSegment);
    }
    // Match number of data points to custom date range, to fit one segment
    else if (pHData.length > 0 && showCustomDateRange == true) {
      int customDataPoints = ((sensorDataToDate.millisecondsSinceEpoch
                                - sensorDataFromDate.millisecondsSinceEpoch)
                                  / 1000).round();
      // Divide by 900 because 900 seconds = 1 data point
      customDataPoints = (customDataPoints / 900).round();
      print("Custom data points: $customDataPoints");
      splitDataIntoSegments(customDataPoints);
    }
    loadingData = false;
    print("Row count: ${pHData.length}");
    notifyListeners();
  }

  void splitDataIntoSegments(int segmentCount){
    int rowCount = pHData.length;
    int numberOfSegments = 0;
    if (!showCustomDateRange) {
      numberOfSegments = (rowCount / segmentCount).ceil();
    } else {
      numberOfSegments = 1;
    }
    for(int i =1;i<= numberOfSegments;i++){
      print("Segment count $i");
      int startRange = (i-1) * segmentCount;
      int endRange = i * segmentCount;
      if(endRange >= pHData.length){
        endRange = pHData.length -1;
      }
      setDataSegment(pHData.getRange(startRange, endRange).toList());
    }
  }

  void setDataSegment(List<ChartData> segment){

    List<num> phValues = segment.map((dataPoint) => dataPoint.dataReading).toList();
    int timesOver = 0;
    int timesUnder = 0;
    double percentTimeUnder = 0;
    double percentTimeOver = 0;

    phValues.forEach((value) {
      if (value > timesOverValue) {
        timesOver++;
        if (value > 8) {
        }
      } else if (value <= timesUnderValue) {
        timesUnder++;
      }
    });

    segment.forEach((element) {
      print("timestamp: ${element.timeStamp}");
    });

    percentTimeUnder = roundDouble((timesUnder / (timesUnder +  timesOver) * 100), 1);
    percentTimeOver = roundDouble((timesOver / (timesUnder +  timesOver) * 100), 1);
    double average = roundDouble(((phValues.reduce((first, next) => first+next))/(segment.length)), 1);
    double minPh = phValues.reduce(min);
    double maxPh = phValues.reduce(max);

    if (showCustomDateRange == true) {
      segment.sort((a,b) => a.timeStamp.compareTo(b.timeStamp));
    }

    DisplayDataModel dataModel = DisplayDataModel(
      startDate: segment.first.timeStamp,
      endDate: segment.last.timeStamp,
      chartData: segment,
      maxPh: maxPh,
      minPh: minPh,
      averagePh: average,
      timesOver: timesOver,
      timesUnder: timesUnder,
      percentTimeUnder: percentTimeUnder,
      percentTimeOver: percentTimeOver
    );

    // Needed to reset segments and display custom date range in one segment
    if (showCustomDateRange == true) {
        showCustomDateRange = false;
        currentSegment = 0;
        displaySegments.clear();
        print("First timestamp: ${segment.first.timeStamp}");
        print("Last timestamp: ${segment.last.timeStamp}");
        displaySegments.add(dataModel);
    }
    else {
      if (clearDatesSelected == true) {
        displaySegments.clear();
        clearDatesSelected = false;
      }
      displaySegments.add(dataModel);
    }
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
    clearDatesSelected = true;
    getSensorDataFromCloud();
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}