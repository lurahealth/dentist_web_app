import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/services/CognitoUserSingleton.dart';
import 'package:lura_dentist_webapp/utils/RestEndpoints.dart';

class NewPatientProvider with ChangeNotifier{
  
  String patientName;
  String patientEmail;
  String patientReference = "";
  
  bool patientNameValid = true;
  bool patientEmailValid = true;
  bool patientIdValid = true;

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

  void checkPatientReference(String value){
    if(value != null && value.length > 0){
      patientReference = value;
      patientIdValid = true;
    }else{
      patientReference = " ";
      patientIdValid = false;
    }

    notifyListeners();
  }

  void checkFields(){
    checkPatientName(patientName);
    checkPatientEmail(patientEmail);
  }

  Future<void> registerNewPatient() async {
    checkFields();
    if(patientEmailValid && patientNameValid){
       setPatientRecord(patientName, patientEmail, patientReference);
    }
  }
}