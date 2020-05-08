import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/models/patient/PatientModel.dart';
import 'package:lura_dentist_webapp/providers/MainUIScreenProvider.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';
import 'package:provider/provider.dart';

class PatientListItem extends StatelessWidget {

  final PatientModel patient;
  PatientListItem(this.patient);

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var profileImage = CircleAvatar(
      radius: width * 0.055,
      backgroundColor: LURA_BLUE,
      child: CircleAvatar(
        radius: width * 0.05,
        backgroundColor: Colors.white,
        child: Icon(Icons.person),
      ),
    );
    return GestureDetector(
      onTap:() => Navigator.pushNamed(context, GRAPH_SCREEN, arguments: patient),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 5,
          child: Container(
            height: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: profileImage,
                ),
                SizedBox(height: height*0.03,),
                Column(
//                mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(patient.patientName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(patient.patientReference, style: TextStyle(fontSize: 16),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
