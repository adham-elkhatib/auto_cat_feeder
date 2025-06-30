import 'dart:convert';

import 'package:flutter/material.dart';

class Meal {
  final String id;
  int serving;
  final TimeOfDay time;
  bool isEnabled;

  Meal({
    required this.id,
    required this.serving,
    required this.time,
    required this.isEnabled,
  });

  Meal copyWith({
    String? id,
    int? serving,
    TimeOfDay? time,
    bool? isEnabled,
  }) {
    return Meal(
      id: id ?? this.id,
      serving: serving ?? this.serving,
      time: time ?? this.time,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'serving': serving,
        'time': '${time.hour}:${time.minute}',
        'is_enabled': isEnabled,
      };

  factory Meal.fromMap(Map<String, dynamic> map) {
    final timeParts = (map['time'] as String).split(':');
    final parsedTime = TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1]),
    );

    return Meal(
      id: map['id'] ?? '',
      serving: map['serving'] ?? 0,
      time: parsedTime,
      isEnabled: map['is_enabled'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Meal.fromJson(String source) => Meal.fromMap(json.decode(source));
}
