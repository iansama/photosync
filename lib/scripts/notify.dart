// ignore_for_file: avoid_print

notifyAlert(String message) {
  String decor = "===========";
  printNow("$decor [ ALERT: $message ] $decor");
}

notifyStatus(String message) {
  String decor = "++++----++++";
  printNow("$decor [ (STARTUS) :: $message ] $decor");
}

printNow(String message) {
  print("__________________________________________________________________");
  print(message);
}
