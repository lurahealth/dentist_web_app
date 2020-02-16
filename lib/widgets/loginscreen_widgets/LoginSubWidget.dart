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

    final emailTextField = Column(
      children: <Widget>[
        TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: provider.checkEmail,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.alternate_email,
              ),
              hintText: LOGIN_SCREEN_EMAIL_HINT,
              labelText: LOGIN_SCREEN_EMAIL_LABEL
          ),
        ),
        Visibility(
            visible: !provider.emailValid,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    LOGIN_SCREEN_EMAIL_ERROR,
                    style: ERROR_TEXT,
                  ),
                ],
              ),
            ))
      ],
    );

    final passwordTextField = Column(
      children: <Widget>[
        TextField(
          obscureText: !provider.showPassword,
          onChanged: provider.checkLoginPassword,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.vpn_key,
              ),
              suffixIcon: IconButton(
                onPressed: provider.togglePasswordVisibility,
                icon: provider.passwordIcon,
                color: LURA_LIGHT_ORANGE,
              ),
              hintText: LOGIN_SCREEN_PASSWORD_HINT,
              labelText: LOGIN_SCREEN_PASSWORD_LABEL),

        ),
        Visibility(
            visible: !provider.passwordValid,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    LOGIN_SCREEN_PASSWORD_ERROR,
                    style: ERROR_TEXT,
                  ),
                ],
              ),
            ))
      ],
    );

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
