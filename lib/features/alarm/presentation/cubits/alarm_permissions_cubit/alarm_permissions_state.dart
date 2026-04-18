part of 'alarm_permissions_cubit.dart';

abstract class AlarmPermissionsState {}

class AlarmPermissionInitial extends AlarmPermissionsState {}

class AlarmPermissionFailure extends AlarmPermissionsState {
  final String message;
  AlarmPermissionFailure({required this.message});
}
