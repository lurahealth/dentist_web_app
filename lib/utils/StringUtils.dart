// Route Names
import 'package:intl/intl.dart';

const LOGIN_SCREEN = "/";
const NEW_PATIENT_SCREEN = "/newPatientScreen";
const MAIN_UI_SCREEN = "/mainUIScreen";
const PATIENT_LIST_SCREEN = "/patientListScreen";
const GRAPH_SCREEN = "/graphScreen";

// // columns names
const String ROW_ID = "row_id"; // Primary key, auto-incremented
const String PH = "ph"; // pH reading
const String BATTERY = "battery"; // battery voltage reading
const String TEMPERATURE = "temperature"; // temperature reading
const String CONNETION_TIME = "connection_time"; // time to connect to the sensor
const String TIME_STAMP = "time_stamp"; // time stamp of the reading in UTC
const String NOTES = "notes"; // Note for a sensor reading
const String DEVICE_ID = "device_id"; // Device sending the data
const String UPLOADED = "uploaded"; // if sensor data has been uploaded set to 1 else set to 0

// Patient Model
const String PATIENT_ID = "patient_id";
const String DENTIST_EMAIL = "dentist_email";
const String PATIENT_EMAIL = "patient_email";
const String PATIENT_NAME = "patient_name";
const String PATIENT_REFERENCE = "patient_reference";
const String CONFIRMED = "confirmed";


// Cognito statuses
const String USER_LOGGED_IN = "user_logged_in";
const String USER_LOGIN_FAILED = "user_login_failed";
const String NEW_PASSWORD_REQUIRED = "New Password required";
const String PASSWORD_CHANGE_SUCCESS = "password_reset_success";
const String PASSWORD_CHANGE_FAILED = "password_reset_failed";
const String PASSWORD_RESET_FAILED = "password_reset_failed";

// Date format
DateFormat dateDisplayFormat = DateFormat("MMMM dd, yyyy");

// Password regex
const String PASSWORD_REGEX = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*-?&^~]{6,}$';

/// ******************************************Screen Text***********************/

// Login Screen
const String LOGIN_SCREEN_TITLE = "Log In";
const String LOGIN_SCREEN_EMAIL_HINT = "Enter your email address";
const String LOGIN_SCREEN_EMAIL_LABEL = "Email";
const String LOGIN_SCREEN_EMAIL_ERROR = "Please enter a valid email address";
const String LOGIN_SCREEN_PASSWORD_HINT = "Enter your password";
const String LOGIN_SCREEN_PASSWORD_LABEL = "Password";
const String LOGIN_SCREEN_PASSWORD_ERROR = "Please enter your password to login";
const String LOGIN_BUTTON_TEST = "Log in now";
const String LOGIN_LOADING_MESSAGE = "Logging in";

// Reset Password Screen
const String PASSWORD_RESET_SCREEN_TITLE =  "Password Reset";
const String PASSWORD_RESET_SCREEN_SUB_TITLE = "Your password has expired and needs to be reset";
const String PASSWORD_RESET_SCREEN_NEW_PASSWORD_LABEL = "New Password";
const String PASSWORD_RESET_SCREEN_NEW_PASSWORD_HINT = "Please enter a new password";
const String PASSWORD_RESET_SCREEN_NEW_PASSWORD_ERROR = "Password needs to contain at least \n "
                                                        "1 upper case character \n "
                                                        "1 lower case character \n "
                                                        "1 number \n "
                                                        "1 special character (@\$!%*-?&^~)";
const String PASSWORD_RESET_SCREEN_CONFIRM_PASSWORD_HINT = "Re-Enter your password";
const String PASSWORD_RESET_SCREEN_CONFIRM_PASSWORD_LABEL = "Confirm Password";
const String PASSWORD_RESET_SCREEN_CONFIRM_PASSWORD_ERROR = "Passwords do not match";
const String PASSWORD_RESET_PASSWORD_BUTTON = "Reset Password";
const String PASSWORD_RESET_SCREEN_LOADING_MESSAGE = "Setting new password and logging in";

// New Patient Screen
const String NEW_PATIENT_NAME_HINT = "Enter patient full name";
const String NEW_PATIENT_NAME_LABEL = "Patient name";
const String NEW_PATIENT_NAME_ERROR = "Need a name to create a new patient!";
const String NEW_PATIENT_EMAIL_HINT = "Enter patients email address";
const String NEW_PATIENT_EMAIL_LABEL = "Patient email";
const String NEW_PATIENT_EMAIL_ERROR = "Please enter a valid email address";
const String NEW_PATIENT_PATIENT_ID_HINT = "Enter patient id (optional)";
const String NEW_PATIENT_PATIENT_ID_LABEL = "Patient id";

// Patients list screen
const String PATIENTS_LIST_DOWNLOADING_MESSAGE = "Downloading Patients";
