import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/PasswordResetProvider.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';
import 'package:provider/provider.dart';
import '../LoadingWidget.dart';

class PasswordResetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PasswordResetProvider(),
      child: PasswordResetWidget(),
    );
  }
}


class PasswordResetWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final PasswordResetProvider provider = Provider.of<PasswordResetProvider>(context);

    final title = Text(
      PASSWORD_RESET_SCREEN_TITLE,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 30, color: LURA_BLUE),
    );

    final subTitle = Text(
      PASSWORD_RESET_SCREEN_SUB_TITLE,
      style: TextStyle(fontSize: 20, color: LURA_BLUE),
    );

    final passwordTextField = Column(
      children: <Widget>[
        TextField(
          obscureText: !provider.showPassword,
          onChanged: provider.newPasswordCheck,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.vpn_key,
              ),
              suffixIcon: IconButton(
                onPressed: provider.togglePasswordVisibility,
                icon: provider.passwordIcon,
              ),
              hintText: PASSWORD_RESET_SCREEN_NEW_PASSWORD_HINT,
              labelText: PASSWORD_RESET_SCREEN_NEW_PASSWORD_LABEL),

        ),
        Visibility(
            visible: !provider.newPasswordValid,
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
                    PASSWORD_RESET_SCREEN_NEW_PASSWORD_ERROR,
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
          onChanged: provider.confirmNewPasswordCheck,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock_outline,
              ),
              suffixIcon: IconButton(
                onPressed: provider.togglePasswordVisibility,
                icon: provider.passwordIcon,
              ),
              hintText: PASSWORD_RESET_SCREEN_CONFIRM_PASSWORD_HINT,
              labelText: PASSWORD_RESET_SCREEN_CONFIRM_PASSWORD_LABEL),

        ),
        Visibility(
            visible: !provider.confirmNewPasswordValid,
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
                    PASSWORD_RESET_SCREEN_CONFIRM_PASSWORD_ERROR,
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
        onPressed: () => provider.resetPassword(context),
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
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: passwordTextField,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: confirmPasswordTextField,
                ),
                SizedBox(height: 40,),
                resetPasswordButton
              ],
            ),
          ),
          Visibility(
              visible: provider.loading,
              child: LoadingWidget(PASSWORD_RESET_SCREEN_LOADING_MESSAGE, LURA_BLUE)
          ),
        ],
      ),),),);
  }
}
