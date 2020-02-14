// Route Names
import 'package:intl/intl.dart';

const GRAPH_SCREEN = "/";

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

// DateTime formatters
DateFormat fromJson = DateFormat("yyyy-MM-dd'T'");

// Cognito statuses
const String USER_LOGGED_IN = "user_logged_in";
const String USER_LOGIN_FAILED = "user_login_failed";
const String FORCE_PASSWORD_RESET = "force_password_reset";
const String PASSWORD_CHANGE_SUCCESS = "password_reset_success";
const String PASSWORD_CHANGE_FAILED = "password_reset_failed";
