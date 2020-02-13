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
  //2020-02-13T12:27:14.000Z
  DateFormat fromJson =  DateFormat("yyyy-MM-dd'T'");