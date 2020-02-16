import 'dart:convert';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/services.dart';
import 'package:lura_dentist_webapp/models/CognitoConfig.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';

class CognitoUserPoolProvider{

  // global instance of CognitoUserSession and CognitoUserPool
  CognitoUserSession _session;
  CognitoUserPool _cognitoUserPool;
  CognitoUser _cognitoUser;

  CognitoUserPoolProvider._privateConstructor();

  static final CognitoUserPoolProvider _instance = CognitoUserPoolProvider._privateConstructor();

  static CognitoUserPoolProvider get instance { return _instance;}


  Future<CognitoUserPool> get userPool async {
    if(_cognitoUserPool == null) {
      String configString = await rootBundle.loadString('assets/config.json');
      print("Config string $configString");
      CognitoConfig config = CognitoConfig.fromJson(json.decode(configString));

      _cognitoUserPool = CognitoUserPool(config.poolId, config.clientId);
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
    print(_session.idToken.getExpiration());
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


}