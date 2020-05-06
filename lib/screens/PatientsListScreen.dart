import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/PatientsListProvider.dart';
import 'package:provider/provider.dart';

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
    final PatientsListProvider provider = Provider.of<PatientsListProvider>(context);
    if(!provider.patientsLoaded){
      provider.getPatients();
    }

    return Container();
  }
}

