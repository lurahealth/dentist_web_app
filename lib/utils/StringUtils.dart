

// Route Names
const GRAPH_SCREEN = "/graphScreen";
const LOGIN_SCREEN = "/";
const NEW_PATIENT_SCREEN = "/newPatientScreen";
const MAIN_UI_SCREEN = "/mainUIScreen";

// // columns names
final String ROW_ID = "row_id"; // Primary key, auto-incremented
final String PH = "ph"; // pH reading
final String BATTERY = "battery"; // battery voltage reading
final String TEMPERATURE = "temperature"; // temperature reading
final String CONNETION_TIME = "connection_time"; // time to connect to the sensor
final String TIME_STAMP = "time_stamp"; // time stamp of the reading in UTC
final String NOTES = "notes"; // Note for a sensor reading
final String DEVICE_ID = "device_id"; // Device sending the data
final String UPLOADED = "uploaded"; // if sensor data has been uploaded set to 1 else set to 0


// Cognito statuses
const String USER_LOGGED_IN = "user_logged_in";
const String USER_LOGIN_FAILED = "user_login_failed";
const String NEW_PASSWORD_REQUIRED = "New Password required";
const String PASSWORD_CHANGE_SUCCESS = "password_reset_success";
const String PASSWORD_CHANGE_FAILED = "password_reset_failed";
const String PASSWORD_RESET_FAILED = "passowrd_rest_dailed";

// Password regex
const String PASSWORD_REGEX = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*-?&^~]{6,}$';

/// ******************************************Screen Text***********************/

// Login Screen
const String LOGIN_SCREEN_TITLE = "Log In";
const String LOGIN_SCREEN_EMAIL_HINT = "Enter your email address";
const String LOGIN_SCREEN_EMAIL_LABEL = "Email";
const String LOGIN_SCREEN_EMAIL_ERROR = "Please enter a valid email address!";
const String LOGIN_SCREEN_PASSWORD_HINT = "Enter your password";
const String LOGIN_SCREEN_PASSWORD_LABEL = "Password";
const String LOGIN_SCREEN_PASSWORD_ERROR = "Please enter your password to login!";
const String LOGIN_BUTTON_TEST = "Log in now";
const String LOGIN_LOADING_MESSAGE = "Loggin you in!";

// Reset Password Screen
const String PASSWORD_RESET_SCREEN_TITLE =  "Password Reset";
const String PASSWORD_RESET_SCREEN_SUB_TITLE = "Your password has expired and needs to be reset";
const String PASSWORD_RESET_SCREEN_NEW_PASSWORD_LABEL = "New Password";
const String PASSWORD_RESET_SCREEN_NEW_PASSWORD_HINT = "Please enter a new password!";
const String PASSWORD_RESET_SCREEN_NEW_PASSWORD_ERROR = "Password need to container atleast \n "
                                                        "1 upper case charecter \n "
                                                        "1 lower case charecter \n "
                                                        "1 number \n "
                                                        "1 special charecter (@\$!%*-?&^~)";
const String PASSWORD_RESET_SCREEN_CONFIRM_PASSWORD_HINT = "Re-Enter your password";
const String PASSWORD_RESET_SCREEN_CONFIRM_PASSWORD_LABEL = "Confirm Password";
const String PASSWORD_RESET_SCREEN_CONFIRM_PASSWORD_ERROR = "Passwords do not match!";
const String PASSWORD_RESET_PASSWORD_BUTTON = "Reset Password";
const String PASSWORD_RESET_SCREEN_LOADING_MESSAGE = "Setting new password and loggin in!";

// New Patient Screen
const String NEW_PATIENT_NAME_HINT = "Enter patinet fullname";
const String NEW_PATIENT_NAME_LABEL = "Patient name";
const String NEW_PATIENT_NAME_ERROR = "Need a name to create a new patient!";
const String NEW_PATIENT_EMAIL_HINT = "Enter patients email address";
const String NEW_PATIENT_EMAIL_LABEL = "Patient email";
const String NEW_PATIENT_EMAIL_ERROR = "Please enter a valid email address";
const String NEW_PATIENT_PATIENT_ID_HINT = "Enter patient id(optional)";
const String NEW_PATIENT_PATIENT_ID_LABEL = "Patient id";
