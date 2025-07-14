import 'package:flutter/material.dart';

class MealEntity {
  final String id;
  final int serving;
  final TimeOfDay time;
  final bool isEnabled;
  final String userId;

  const MealEntity({
    required this.id,
    required this.serving,
    required this.time,
    required this.isEnabled,
    required this.userId,
  });

  MealEntity copyWith({
    String? id,
    int? serving,
    TimeOfDay? time,
    bool? isEnabled,
    String? userId,
  }) {
    return MealEntity(
      id: id ?? this.id,
      serving: serving ?? this.serving,
      time: time ?? this.time,
      isEnabled: isEnabled ?? this.isEnabled,
      userId: userId ?? this.userId,
    );
  }
}
