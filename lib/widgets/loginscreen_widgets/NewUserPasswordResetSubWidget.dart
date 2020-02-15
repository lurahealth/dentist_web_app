import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/LoginProvider.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';

import '../LoadingWidget.dart';

class NewUserPasswordResetSubWidget extends StatelessWidget {

  final LoginProvider provider;

  NewUserPasswordResetSubWidget(this.provider);

  @override
  Widget build(BuildContext context) {

    final title = Text(
      "New User Password Reset",
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 30, color: LURA_BLUE),
    );

    final subTitle = Text(
      "New User are required to rest their password when they login for the first time",
      style: TextStyle(fontSize: 20, color: LURA_BLUE),
    );

    final passwordTextField = Column(
      children: <Widget>[
        TextField(
          obscureText: !provider.showPassword,
          onChanged: provider.newUserPasswordCheck,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.vpn_key,
              ),
              suffixIcon: IconButton(
                onPressed: provider.togglePasswordVisibility,
                icon: provider.passwordIcon,
              ),
              hintText: "Enter your new password",
              labelText: "Password"),

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
                    "Please enter your password to login!",
                    style: ERROR_TEXT,
                  ),
                ],
              ),
            ))
      ],
    );

    final confirmPasswordTextField = Column(
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
              ),
              hintText: "Re-Enter your password",
              labelText: "Password"),

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
                    "Please enter your password to login!",
                    style: ERROR_TEXT,
                  ),
                ],
              ),
            ))
      ],
    );

    final resetPasswordButton = Material(
      borderRadius: BorderRadius.circular(8.0),
      elevation: 5.0,
      color: LURA_BLUE,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => provider.newUserPasswordRest(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            SizedBox(width: 10,),
            Text(
              "Reset Password",
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
                Center(child: subTitle),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: passwordTextField,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: confirmPasswordTextField,
                ),
                resetPasswordButton
              ],
            ),
          ),
          Visibility(
              visible: provider.loading,
              child: LoadingWidget("Setting new password", LURA_BLUE)
          ),
        ],
      ),),),);
  }
}
