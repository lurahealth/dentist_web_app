import 'dart:convert';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/services.dart';
import 'package:lura_dentist_webapp/models/CognitoConfig.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';

class CognitoUserSingleton{

  CognitoUserSession _session;
  CognitoUserPool _cognitoUserPool;
  CognitoUser _cognitoUser;

  CognitoUserSingleton._privateConstructor();

  static final CognitoUserSingleton _instance = CognitoUserSingleton._privateConstructor();

  static CognitoUserSingleton get instance { return _instance;}


  Future<CognitoUserPool> get userPool async {
    if(_cognitoUserPool == null) {
      _cognitoUserPool = new CognitoUserPool(
        'us-east-1_w748gFhji',
        '413vbjt1uflp1iborqem06e572',
      );
    }

    return _cognitoUserPool;
  }

  CognitoUser getUser(CognitoUserPool userPool,{String email}){
    if(_cognitoUser == null){
      _cognitoUser = CognitoUser(email, userPool);
    }

    return _cognitoUser;
  }

  String get token {
    print(_session.idToken.getJwtToken());
    return _session.idToken.getJwtToken();
  }

  Future<String> loginUser(String email, String password) async{
    print("Loggins in user Email: $email Password: $password");
    final CognitoUserPool userPool = await this.userPool;
    final CognitoUser user = getUser(userPool, email: email);
    final AuthenticationDetails authDetails = AuthenticationDetails(
                                                    username: email,
                                                    password: password
                                                );
    try{
      _session = await user.authenticateUser(authDetails);
    }on CognitoUserNewPasswordRequiredException catch (e) {
      return e.message;
    } on Error catch (e){
      return "Unknows error ${e.toString()}";
    }

    return USER_LOGGED_IN;
  }

  Future<String> newUserPasswordReset(String newPassword) async {
    print("Resetting password");
    final CognitoUserPool userPool = await this.userPool;
    final CognitoUser user = getUser(userPool);
    try {
      _session = await user.sendNewPasswordRequiredAnswer(newPassword);
    } catch (e) {
      return PASSWORD_RESET_FAILED +" "+e.toString();
    }

    return PASSWORD_CHANGE_SUCCESS;
  }

  Future<CognitoUser> registerNewPatient(String email, String patientName) async {
    final CognitoUserPool userPool = await this.userPool;
    final userAttributes = [
      new AttributeArg(name: 'email', value: email),
      new AttributeArg(name: 'name', value: patientName),
    ];
    CognitoUserPoolData data;
    try {
      data = await userPool.signUp(
        email,
        'Rar!197382465',
        userAttributes: userAttributes
      );
    } catch (e) {
      print("Error registering new patinet ${e.toString()}");
    }

    return data.user;
  }
}