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

      CognitoUserSingleton.instance
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
}
