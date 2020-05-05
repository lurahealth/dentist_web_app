import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/MainUIScreenProvider.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';
import 'package:provider/provider.dart';

class MainUIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainUIScreenProvider(),
      child: MainUIWidget(),
    );
  }
}

class MainUIWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Container sideBar = Container(
      width: MediaQuery.of(context).size.width * 0.33,
      color: LURA_BLUE,
    );

    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[sideBar],
        ),
      ),
    );
  }
}
