import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/models/patient/PatientModel.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';

class MainUIScreenProvider with ChangeNotifier{

  int currentScreen = 0;
  PatientModel currentPatient;

  void patientSelected(PatientModel patient){
    currentPatient = patient;
    currentScreen = 1;
  }

}