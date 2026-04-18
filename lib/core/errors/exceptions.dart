class UnknownException implements Exception {
  final String message;
  UnknownException({required this.message});
}

class UnsavedException implements Exception {
  final String message;
  UnsavedException({required this.message});
}

class GetAlarmsException implements Exception {
  final String message;
  GetAlarmsException({required this.message});
}

class DeleteAlarmException implements Exception {
  final String message;
  DeleteAlarmException({required this.message});
}

class UpdateAlarmException implements Exception {
  final String message;
  UpdateAlarmException({required this.message});
}

class OpenAppInfoException implements Exception {
  final String message;
  OpenAppInfoException({required this.message});
}

class GetDeviceNameException implements Exception {
  final String message;
  GetDeviceNameException({required this.message});
}

class AutoStartException implements Exception {
  final String message;
  AutoStartException({required this.message});
}

class IgnoreBatteryException implements Exception {
  final String message;
  IgnoreBatteryException({required this.message});
}
