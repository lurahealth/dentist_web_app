import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/services/CognitoUserSingleton.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';

class LoginProvider with ChangeNotifier {
  String userEmail;
  String password;

  String newPassword;
  String confirmNewPassword;

  bool emailValid = true;
  bool passwordValid = true;
  bool newPasswordValid = true;
  bool confirmNewPasswordValid = true;
  bool showPassword = false;
  bool loading = false;

  Icon passwordIcon = Icon(Icons.visibility_off);

  bool loginError = false;
  String loginErrorMessage = "";

  int displayWidget = 0;

  Future<void> loginUser(BuildContext context) async {
    checkLoginFields();
    if (userEmail != null && password != null) {
      loginError = false;
      loading = true;
      notifyListeners();

      CognitoUserPoolProvider.instance
          .loginUser(userEmail, password)
          .then((response)
      {
        print("Success: $response");
        loading = false;
        if (response == NEW_PASSWORD_REQUIRED) {
          print("New password required");
          displayWidget = 1;
          notifyListeners();
        } else {
          Navigator.popAndPushNamed(context, GRAPH_SCREEN);
        }
      }, onError: loginFailed);
    }
  }

  void passwordResetFailed(error) {
    print("Password rest failed ${error.toString()}");
  }

  void loginFailed(error) {
    print("Error logging in: ${error.toString()}");
    loginError = true;
    loginErrorMessage = error.message;
    loading = false;
    notifyListeners();
  }



  void togglePasswordVisibility() {
    if (showPassword) {
      showPassword = false;
      passwordIcon = Icon(Icons.visibility_off);
    } else {
      showPassword = true;
      passwordIcon = Icon(Icons.visibility);
    }

    notifyListeners();
  }

  checkLoginFields() {
    checkEmail(userEmail);
    checkLoginPassword(password);
  }

  newUserPasswordRest(BuildContext context) {
    print("New user password rest");
    checkNewUserPasswordFields();

    if (newPasswordValid && confirmNewPasswordValid) {
      CognitoUserPoolProvider.instance
          .newUserPasswordReset(userEmail, newPassword)
          .then((response) {
        print("Password reset succcess $response");
        Navigator.popAndPushNamed(context, GRAPH_SCREEN);
      }, onError: passwordResetFailed);
    }
  }

  checkEmail(String value) {
    if (value != null && value.length > 0 && EmailValidator.validate(value)) {
      emailValid = true;
      userEmail = value.trim();
    } else {
      emailValid = false;
      userEmail = null;
    }

    notifyListeners();
  }

  checkLoginPassword(String value) {
    if (value != null && value.length > 0) {
      passwordValid = true;
      password = value.trim();
    } else {
      passwordValid = false;
      password = null;
    }

    notifyListeners();
  }

  void newUserPasswordCheck(String value) {
      RegExp passwordCheck = RegExp(PASSWORD_REGEX);
      if(value != null && value.length > 0 && passwordCheck.hasMatch(value)){
        newPassword = value.trim();
      }else{
        newPassword = null;
        newPasswordValid = false;
      }

      notifyListeners();
  }

  void newUserConfirmPasswordCheck(String value) {

    if(value != null && value.length > 0 && value == newPassword ){
      confirmNewPasswordValid = true;
      confirmNewPassword = value.trim();
    }else{
      confirmNewPasswordValid = false;
      confirmNewPassword = null;
    }

    notifyListeners();
  }

  void checkNewUserPasswordFields() {
    newUserPasswordCheck(newPassword);
    newUserConfirmPasswordCheck(confirmNewPassword);
  }
}
