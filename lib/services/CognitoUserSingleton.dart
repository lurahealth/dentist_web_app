import 'dart:convert';
import 'dart:math';

import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:flutter/services.dart';
import 'package:lura_dentist_webapp/models/CognitoConfig.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';

class CognitoUserPoolProvider{
  static CognitoUserPool _cognitoUserPool;
  static final CognitoUserPoolProvider cognitoUserPoolProvider = CognitoUserPoolProvider._();
  CognitoUserSession session;

  CognitoUserPoolProvider._();

  Future<CognitoUserPool> get cognitoUserPool async {
    if (_cognitoUserPool != null) {
      return _cognitoUserPool;
    } else {
      return await initCognitoUserPool();
    }
  }

  Future<CognitoUserPool> initCognitoUserPool() async {
    String configString = await rootBundle.loadString('assets/config.json');
    CognitoConfig config = CognitoConfig.fromJson(json.decode(configString));

    return CognitoUserPool(config.poolId,config.clientId);
  }

  Future<String> loginUser(String email, String password) async{
    final userPool = await cognitoUserPool;
    final CognitoUser user = CognitoUser(email, userPool);
    final AuthenticationDetails authDetails = AuthenticationDetails(
                                                    username: email,
                                                    password: password
                                                );
    try{
      session = await user.authenticateUser(authDetails);
    }on CognitoUserNewPasswordRequiredException catch (e) {
      return FORCE_PASSWORD_RESET + e.message;
    }

    return USER_LOGGED_IN;
  }

  Future<String> resetPassword(String email, String oldPassword,
      String newPassword) async {
    final userPool = await cognitoUserPool;
    final CognitoUser user = CognitoUser(email, userPool);
    bool passwordChanged;
    try {
      passwordChanged = await user.changePassword(
          'oldPassword', 'newPassword');
    } catch (e) {
      return PASSWORD_CHANGE_FAILED + e.toString();
    }

    if (passwordChanged)
      return PASSWORD_CHANGE_SUCCESS;
    else
      return PASSWORD_CHANGE_FAILED;
  }


}