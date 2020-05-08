import 'package:lura_dentist_webapp/utils/StringUtils.dart';

class PatientModel{
  String patientName;
  String patientReference;
  String patientEmail;
  int patientId;

  PatientModel(this.patientName, this.patientReference, this.patientEmail,
      this.patientId);

  @override
  String toString() {
    return 'PatientModel{patientName: $patientName, patientReference: $patientReference, patientEmail: $patientEmail, patientId: $patientId}';
  }

  factory PatientModel.fromJson(Map<String, dynamic> map){
    return PatientModel(
      map[PATIENT_NAME],
      map[PATIENT_REFERENCE],
      map[PATIENT_EMAIL],
      map[PATIENT_ID]
    );
  }
}