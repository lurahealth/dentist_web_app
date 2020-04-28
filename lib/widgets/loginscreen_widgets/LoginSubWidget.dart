import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/LoginProvider.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';
import 'package:lura_dentist_webapp/widgets/LoadingWidget.dart';

class LoginSubWidget extends StatelessWidget {

  final LoginProvider provider;

  LoginSubWidget(this.provider);

  @override
  Widget build(BuildContext context) {

    final title = Text(
      LOGIN_SCREEN_TITLE,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 30, color: LURA_BLUE),
    );

    final emailTextField = textField(LOGIN_SCREEN_EMAIL_HINT,
                                     LOGIN_SCREEN_EMAIL_LABEL,
                                     TextInputType.emailAddress,
                                     provider.checkEmail,
                                     provider.emailValid,
                                     LOGIN_SCREEN_EMAIL_ERROR,
                                     Icons.alternate_email);

    final passwordTextField = textField(LOGIN_SCREEN_PASSWORD_HINT,
                                        LOGIN_SCREEN_PASSWORD_LABEL,
                                        TextInputType.text,
                                        provider.checkLoginPassword,
                                        provider.passwordValid,
                                        LOGIN_SCREEN_PASSWORD_ERROR,
                                        Icons.vpn_key,
                                        obscureText: !provider.showPassword,
                                        suffixIcon: IconButton(
                                            icon: provider.passwordIcon,
                                            onPressed: provider.togglePasswordVisibility),);


    final errorText = Visibility(
      visible: provider.loginError,
      child: new Text(
        provider.loginErrorMessage,
        style: ERROR_TEXT,
      ),
    );

    final loginButton = Material(
      borderRadius: BorderRadius.circular(8.0),
      elevation: 5.0,
      color: LURA_BLUE,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => provider.loginUser(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            SizedBox(width: 10,),
            Text(
              LOGIN_BUTTON_TEST,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,),
            ),
          ],
        ),
      ),
    );

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.30,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Visibility(
                visible: !provider.loading,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    title,
                    SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: emailTextField,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: passwordTextField,
                    ),
                    SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: errorText,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: loginButton,
                    )
                  ],
                ),
              ),
              Visibility(
                visible: provider.loading,
                  child: LoadingWidget(LOGIN_LOADING_MESSAGE, LURA_BLUE)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
