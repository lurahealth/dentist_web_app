import 'package:lura_dentist_webapp/models/patient/PatientModel.dart';

class PatientDataResponseModel{
  int rowCount;
  List<PatientModel> patients;

  PatientDataResponseModel(this.rowCount, this.patients);

  factory PatientDataResponseModel.fromJson(Map<String, dynamic> json){
    return PatientDataResponseModel(
        json["rowCount"], 
        json["patients"].forEach((patientJson) => PatientModel.fromJson(patientJson) )
    );
  }

}