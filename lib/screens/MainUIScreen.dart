import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/MainUIScreenProvider.dart';
import 'package:lura_dentist_webapp/screens/GraphScreen.dart';
import 'package:lura_dentist_webapp/screens/PatientsListScreen.dart';
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

    final MainUIScreenProvider provider = Provider.of<MainUIScreenProvider>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final List<Widget> _widgetOptions = <Widget>[
      PatientsListScreen(),
      GraphScreen()
    ];

    final Container dentistDetails = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Dentist Name", style: WHITE_TITLE,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Clinic Name",style: WHITE_SUB_TITLE, ),
          )
        ],
      ),
    );

    final Container sideBar = Container(
      width: width * 0.25,
      height: height,
      color: LURA_BLUE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.all(32.0),
                   child: dentistDetails,
                 ),
                Divider(color: Colors.white,thickness: 2,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Image.asset('assets/splash_screen.png'),
          ),
        ],
      ),
    );



    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            sideBar,
            SizedBox(
              height: height,
              width: width*0.75,
              child: _widgetOptions.elementAt(provider.currentScreen),
            )
          ],
        ),
      ),
    );
  }
}
