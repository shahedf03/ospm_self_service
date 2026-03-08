import 'package:intl/intl.dart';

String getToday() {
  final DateFormat formatter = DateFormat('MMM dd yyyy');
  return formatter.format(DateTime.now()).toString();
}
String getCurrentTime() {
  final now = DateTime.now();
  return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
}
String getCurrentTimeAMPM() {
  final now = DateTime.now();
  final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
  final amPm = now.hour >= 12 ? "PM" : "AM";
  return "$hour:${now.minute.toString().padLeft(2, '0')} $amPm";
}


String _getCurrentTime() {
  return DateFormat('HH:mm:ss').format(DateTime.now());
}

String _getToday() {
  return DateFormat('yyyy-MM-dd').format(DateTime.now());
}