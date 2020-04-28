import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/NewPatinetProvider.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';
import 'package:provider/provider.dart';

class NewPatientDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final NewPatientProvider provider = Provider.of<NewPatientProvider>(context);

    final patientNameTextField = textField(NEW_PATIENT_NAME_HINT,
                                           NEW_PATIENT_NAME_LABEL,
                                           TextInputType.text,
                                           provider.checkPatientName,
                                           provider.patientNameValid,
                                           NEW_PATIENT_NAME_ERROR,
                                           Icons.perm_identity);

    final patientEmailTextField = textField(NEW_PATIENT_EMAIL_HINT,
                                            NEW_PATIENT_EMAIL_LABEL,
                                            TextInputType.emailAddress,
                                            provider.checkPatientEmail,
                                            provider.patientEmailValid,
                                            NEW_PATIENT_EMAIL_ERROR,
                                            Icons.alternate_email);

    final patientIdTextField = textField(NEW_PATIENT_PATIENT_ID_HINT,
                                         NEW_PATIENT_PATIENT_ID_LABEL,
                                         TextInputType.text,
                                         provider.checkPatientId,
                                         true,
                                         "",
                                         Icons.assignment_ind);

    final newPatientButton = RaisedButton(
        onPressed: provider.registerNewPatient,
      child: Text("Register patinet"),
    );

    return AlertDialog(
      title: Text("Register new patinet"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          patientNameTextField,
          patientEmailTextField,
          patientIdTextField,
          newPatientButton
        ],
      ),
    );
  }
}

