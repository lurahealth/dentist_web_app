import 'dart:convert';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/services.dart';
import 'package:lura_dentist_webapp/models/CognitoConfig.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';

class CognitoUserSingleton{

  CognitoUserSession _session;
  CognitoUserPool _cognitoUserPool;
  CognitoUser _cognitoUser;
  String currentUserEmail;

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
    _cognitoUser = null;
    final CognitoUser user = getUser(userPool, email: email);
    final AuthenticationDetails authDetails = AuthenticationDetails(
                                                    username: email,
                                                    password: password
                                                );
    try{
      _session = await user.authenticateUser(authDetails);
      await setCurrentUserEmail();
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
      await setCurrentUserEmail();
    } catch (e) {
      return PASSWORD_RESET_FAILED +" "+e.toString();
    }

    return PASSWORD_CHANGE_SUCCESS;
  }

  Future setCurrentUserEmail() async {

    print("Setting current user email");

    List<CognitoUserAttribute> attributes = await _cognitoUser
        .getUserAttributes();

    CognitoUserAttribute userAttribute = attributes.firstWhere((attribute) => attribute.name == "email" );

    if(userAttribute != null){
      currentUserEmail = userAttribute.value;
    }else{
      currentUserEmail = null;
    }
  }
}