import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/models/patient/PatientDataResponseModel.dart';
import 'package:lura_dentist_webapp/models/patient/PatientModel.dart';
import 'package:lura_dentist_webapp/services/NetworkCommon.dart';
import 'package:lura_dentist_webapp/utils/RestEndpoints.dart';

class PatientsListProvider with ChangeNotifier{
  bool loading = true;
  bool patientsLoaded = false;

  List<PatientModel> patients = [];

  void getPatients(){
    if(!patientsLoaded){
      patientsLoaded = true;
      
       getPatientsForCurrentDentist().then(getPatientSuccessful,
                                           onError: errorGettingPatients);
    }
  }
  
  void getPatientSuccessful(r){
    Map<String, dynamic> result = NetworkCommon().decodeResp(r);
    PatientDataResponseModel patientDataResponseModel = PatientDataResponseModel.fromJson(result);
    patients = patientDataResponseModel.patients;
    print(patientDataResponseModel.rowCount);

    loading = false;
    notifyListeners();
  }

  void errorGettingPatients(error){
    loading = false;
    print(error.toString());
    notifyListeners();
  }
}