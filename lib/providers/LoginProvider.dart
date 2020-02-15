import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/services/CognitoUserSingleton.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';

class LoginProvider with ChangeNotifier {
  String userEmail = "r.rakshak@gmail.com";
  String password = "H!gfZO-x~z^9~0*1!vSQ";
  String newPassword = "_rjE6C:e7ed8,5eN8YB6";

  Future<void> loginUser() async {

    CognitoUserPoolProvider.instance
        .loginUser(userEmail, password)
        .then(loginSuccess, onError: loginFailed);
  }

  void loginSuccess(response) {
    print("Success: $response");
    if(response == NEW_PASSWORD_REQUIRED){
      CognitoUserPoolProvider.instance
          .newUserPasswordReset(userEmail, newPassword)
          .then(passwordResetSuccess, onError: passwordResetFailed);
    }
  }

  void passwordResetSuccess(response){
    print("Password reset succcess $response");
  }

  void passwordResetFailed(error){
    print("Password rest failed ${error.toString()}");
  }

  void loginFailed(error) {
    print("Error logging in: ${error.toString()}");
  }
}
