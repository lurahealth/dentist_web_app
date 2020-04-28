import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class NewPatientProvider with ChangeNotifier{
  
  String patientName;
  String patientEmail;
  String patientId;
  
  bool patientNameValid;
  bool patientEmailValid;
  bool patientIdValid;

  void checkPatientName(String value){
    if(value != null && value.length > 0){
      patientName = value;
      patientNameValid = true;
    }else{
      patientNameValid = false;
      patientName = null;
    }

    notifyListeners();
  }

  void checkPatientEmail(String value){
    if(value != null && EmailValidator.validate(value)){
      patientEmail = value;
      patientEmailValid = true;
    }else{
      patientEmailValid = false;
      patientEmail = null;
    }

    notifyListeners();
  }

  void checkPatientId(String value){
    if(value != null && value.length > 0){
      patientId = value;
      patientIdValid = true;
    }else{
      patientId = null;
      patientIdValid = false;
    }

    notifyListeners();
  }
}