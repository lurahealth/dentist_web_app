import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/NewPatinetProvider.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';
import 'package:lura_dentist_webapp/widgets/LoadingWidget.dart';
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
                                         provider.checkPatientReference,
                                         true,
                                         "",
                                         Icons.assignment_ind);

    final errorMessage = Text(provider.errorText, style: ERROR_TEXT,);

    final newPatientButton = RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0),),
      color: LURA_BLUE,
      onPressed: provider.registerNewPatient,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text("Register patient", style: WHITE_TEXT,),
      ),
    );

    final patientCreated = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.done, color: Colors.green,size: MediaQuery.of(context).size.height*0.15),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Patient created",
            style: GREEN_TEXT.copyWith(fontSize: MediaQuery.of(context).size.height*0.02) ,),
        )
      ],
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: (!provider.loading && !provider.patientCreated),
          child: Center(
            child: Text("Register new patient", style: LURA_BLUE_TEXT,),
          ),
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width*0.20,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Visibility(
                visible: (!provider.loading && !provider.patientCreated),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: patientNameTextField,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: patientEmailTextField,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: patientIdTextField,
                    ),
                    SizedBox(height: 20,),
                    Visibility(
                      visible: provider.error,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: errorMessage,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: newPatientButton,
                    )
                  ],
                ),
              ),
              Visibility(
                visible: provider.loading,
                child: LoadingWidget("Registering patient", LURA_BLUE),
              ),
              Visibility(
                visible: provider.patientCreated,
                child: patientCreated,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

