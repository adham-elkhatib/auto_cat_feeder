import 'package:flutter/material.dart';

class MealParams {
  final int serving;
  final TimeOfDay time;
  final bool isEnabled;

  const MealParams({
    required this.serving,
    required this.time,
    required this.isEnabled,
  });
}

class DeleteMealParams {
  final String id;

  const DeleteMealParams({required this.id});
}

class UpdateMealParams {
  final String id;
  final TimeOfDay time;
  final int serving;
  final bool isEnabled;

  const UpdateMealParams(
      {required this.id,
      required this.time,
      required this.isEnabled,
      required this.serving});
}
