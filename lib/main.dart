import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/utils/RouteGenerator.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Lura Health',
        theme: ThemeData(
            primaryColor: LURA_BLUE,
            accentColor: LURA_ORANGE
        ),
        initialRoute: LOGIN_SCREEN,
        onGenerateRoute: RouteGenerator.generateRoute
    );
  }
}