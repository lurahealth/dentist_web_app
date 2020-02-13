import 'package:lura_dentist_webapp/models/ResponseMessageModel.dart';

class GetDataResponseModel{
  ResponseMessageModel responseMessageModel;

  GetDataResponseModel(this.responseMessageModel);

  factory GetDataResponseModel.fromJson(Map<String, dynamic> json){
    return GetDataResponseModel(
      ResponseMessageModel.fromJson(json["message"])
    );
  }
}