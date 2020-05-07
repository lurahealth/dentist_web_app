import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/NewPatinetProvider.dart';
import 'package:lura_dentist_webapp/providers/PatientsListProvider.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';
import 'package:lura_dentist_webapp/widgets/LoadingWidget.dart';
import 'package:lura_dentist_webapp/widgets/PatientListItem.dart';
import 'package:provider/provider.dart';

import 'NewPatinetDialog.dart';

class PatientsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PatientsListProvider(),
      child: PatientListWidget(),
    );
  }
}

class PatientListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final PatientsListProvider provider =
        Provider.of<PatientsListProvider>(context);
    if (!provider.patientsLoaded) {
      provider.getPatients();
    }

//    final headerImage = Container(
//      width: width,
//      height: height*0.2,
//      color: LURA_BLUE,
//      child: ,
//    );

    final patientsGrid = GridView.builder(
        itemCount: provider.displayPatients.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / 1.2,
          crossAxisCount: (width / 300).round(),
        ),
        itemBuilder: (BuildContext context, int index) {
          return PatientListItem(provider.displayPatients[index]);
        });

    final headerBlock = Material(
      elevation: 10,
      child:Container(
        color: LURA_BLUE,
        height: height * 0.42,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                Image.asset('assets/splash_screen.png'),
                SizedBox(height: height*0.05,),
                TextField(
                  onChanged: provider.patientsSearch,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                      prefixIcon: Icon(Icons.search, color: LURA_ORANGE,),
                      hintText: "Search by Patient name or reference"
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Visibility(
            visible: !provider.loading,
            child: Column(
              children: <Widget>[
//          headerImage,
                headerBlock,
                Expanded(child: patientsGrid)
              ],
            ),
          ),
          Visibility(
            visible: provider.loading,
            child: LoadingWidget(PATIENTS_LIST_DOWNLOADING_MESSAGE, LURA_BLUE),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showNewPatientsDialog(context),
        label: Text("New Patient"),
        icon: Icon(Icons.person_add),
      ),
    );
  }

  Future _showNewPatientsDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
            create: (_) => NewPatientProvider(),
            child: NewPatientDialog(),
          );
        });
  }
}
