import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/screens/GraphScreen.dart';
import 'package:lura_dentist_webapp/screens/LoginScreen.dart';
import 'package:lura_dentist_webapp/screens/NewPatinetScreen.dart';

import 'StringUtils.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case LOGIN_SCREEN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case GRAPH_SCREEN:
        return MaterialPageRoute(builder: (_) => GraphScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
