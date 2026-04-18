abstract class Failures {
  final String message;
  Failures({required this.message});
}

class UnknownFailure extends Failures {
  UnknownFailure({required super.message});
}

class UnsavedFailure extends Failures {
  UnsavedFailure({required super.message});
}

class GetAlarmsFailure extends Failures {
  GetAlarmsFailure({required super.message});
}

class DeleteAlarmFailure extends Failures {
  DeleteAlarmFailure({required super.message});
}

class UpdateAlarmFailure extends Failures {
  UpdateAlarmFailure({required super.message});
}

class OpenAppInfoFailure extends Failures {
  OpenAppInfoFailure({required super.message});
}

class GetDeviceNameFailure extends Failures {
  GetDeviceNameFailure({required super.message});
}

class AutoStartFailure extends Failures {
  AutoStartFailure({required super.message});
}

class IgnorBatteryFailure extends Failures {
  IgnorBatteryFailure({required super.message});
}

class OpenOverAppsFailure extends Failures {
  OpenOverAppsFailure({required super.message});
}
