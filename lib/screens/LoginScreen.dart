import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/LoginProvider.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';
import 'package:lura_dentist_webapp/widgets/loginscreen_widgets/LoginSubWidget.dart';
import 'package:lura_dentist_webapp/widgets/loginscreen_widgets/PasswordResetScreen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: LoginWidget(),
    );
  }
}

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    LoginProvider provider = Provider.of<LoginProvider>(context);

    final List<Widget> _widgetOptions = <Widget>[
      LoginSubWidget(provider),
      PasswordResetScreen()
    ];

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: EdgeInsets.only(top: 60.0, bottom: 60.0, left: 120.0, right: 120.0),
        child: Card(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0)),
          elevation: 5.0,
          child: Container(
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Center(
                    child: Container(
                      color: LURA_BLUE,
                      child: Image.asset('assets/splash_screen.png'),
                      constraints: BoxConstraints.expand(),
                    ),
                  ),
                ),
                Flexible(
                    flex: 6,
                    // Show either the login screen or the password reset screen.
                    // LoginSubWidget or PasswordResetScreen
                    child: _widgetOptions.elementAt(provider.displayWidget)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
