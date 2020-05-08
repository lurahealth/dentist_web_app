import 'package:lura_dentist_webapp/models/patient/PatientModel.dart';

class PatientDataResponseModel{
  int rowCount;
  List<PatientModel> patients;

  PatientDataResponseModel(this.rowCount, this.patients);

  factory PatientDataResponseModel.fromJson(Map<String, dynamic> json){
    var list = json["patients"] as List;
    return PatientDataResponseModel(
        json["rowCount"],
        list.map((i) => PatientModel.fromJson(i)).toList()
    );
  }
}