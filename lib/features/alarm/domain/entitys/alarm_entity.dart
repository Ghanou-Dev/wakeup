import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:g_lab/core/constants/alarm_repited.dart';

class AlarmEntity extends Equatable {
  final String hint;
  final TimeOfDay time;
  final AlarmRepited repited;
  final bool isActive;
  final String id;
  const AlarmEntity({
    required this.hint,
    required this.time,
    required this.repited,
    required this.isActive,
    required this.id,
  });

  @override
  List<Object?> get props => [hint, time, repited, isActive, id];
}
