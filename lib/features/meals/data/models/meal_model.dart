import 'dart:convert';

import 'package:flutter/material.dart';

import '../../domain/entities/meal_entity.dart';

class MealModel {
  final String id;
  final int serving;
  final TimeOfDay time;
  final bool isEnabled;
  final String userId;

  const MealModel({
    required this.id,
    required this.serving,
    required this.time,
    required this.isEnabled,
    required this.userId,
  });

  /// لتحويل الـ Model للـ Entity النقي
  MealEntity toEntity() {
    return MealEntity(
      id: id,
      serving: serving,
      time: time,
      isEnabled: isEnabled,
      userId: userId,
    );
  }

  /// Factory من الـ Entity -> Model
  factory MealModel.fromEntity(MealEntity entity) {
    return MealModel(
      id: entity.id,
      serving: entity.serving,
      time: entity.time,
      isEnabled: entity.isEnabled,
      userId: entity.userId,
    );
  }

  /// من Map
  factory MealModel.fromMap(Map<String, dynamic> map) {
    final timeParts = (map['time'] as String).split(':');
    final parsedTime = TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1]),
    );

    return MealModel(
      id: map['id'] ?? '',
      serving: map['serving'] ?? 0,
      time: parsedTime,
      isEnabled: map['is_enabled'] ?? false,
      userId: map['userId'],
    );
  }

  /// إلى Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serving': serving,
      'time': '${time.hour}:${time.minute}',
      'is_enabled': isEnabled,
      "userId": userId,
    };
  }

  /// من JSON String
  factory MealModel.fromJson(String source) =>
      MealModel.fromMap(json.decode(source));

  /// إلى JSON String
  String toJson() => json.encode(toMap());
}
