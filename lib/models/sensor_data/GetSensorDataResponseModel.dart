import 'package:lura_dentist_webapp/models/sensor_data/SensorDataResponseMessageModel.dart';

class GetSensorDataResponseModel{
  SensorDataResponseMessageModel responseMessageModel;

  GetSensorDataResponseModel(this.responseMessageModel);

  factory GetSensorDataResponseModel.fromJson(Map<String, dynamic> json){
    return GetSensorDataResponseModel(
      SensorDataResponseMessageModel.fromJson(json["message"])
    );
  }
}