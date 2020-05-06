import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/NewPatinetProvider.dart';
import 'package:lura_dentist_webapp/providers/PatientsListProvider.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';
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
    final PatientsListProvider provider =
        Provider.of<PatientsListProvider>(context);
    if (!provider.patientsLoaded) {
      provider.getPatients();
    }

    final patientsGrid = GridView.builder(
        itemCount: provider.patients.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / 1.2,
          crossAxisCount: (MediaQuery.of(context).size.width / 300).round(),
        ),
        itemBuilder: (BuildContext context, int index) {
          return PatientListItem(provider.patients[index]);
        });

    final searchBar = Material(
      elevation: 10,
      child:Container(
        color: LURA_BLUE,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                  prefixIcon: Icon(Icons.search, color: LURA_ORANGE,),
                  hintText: "Search by Patient name or reference"
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          searchBar,
          Expanded(child: patientsGrid)
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
