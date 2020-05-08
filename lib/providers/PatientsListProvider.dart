import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/models/patient/PatientDataResponseModel.dart';
import 'package:lura_dentist_webapp/models/patient/PatientModel.dart';
import 'package:lura_dentist_webapp/services/NetworkCommon.dart';
import 'package:lura_dentist_webapp/utils/RestEndpoints.dart';

class PatientsListProvider with ChangeNotifier{
  bool loading = true;
  bool patientsLoaded = false;

  List<PatientModel> patients = [];
  List<PatientModel> displayPatients = [];

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
    displayPatients = patients;
    print(patientDataResponseModel.rowCount);

    loading = false;
    notifyListeners();
  }

  void patientsSearch(String searchQuery){
    displayPatients = []; // clear the currently displayed patients
    searchQuery = searchQuery.toLowerCase();

    // Searching through their names
    patients.forEach((patient) {
      if(patient.patientName.toLowerCase().contains(searchQuery)){
        displayPatients.add(patient);
      }
    });

    // Searching patient reference
    patients.forEach((patient) {
      if(!displayPatients.contains(patient) &&
         patient.patientReference != null &&
         patient.patientReference.toLowerCase().contains(searchQuery) ){
        displayPatients.add(patient);
      }
    });

    notifyListeners();
  }

  void errorGettingPatients(error){
    loading = false;
    print(error.toString());
    notifyListeners();
  }
}