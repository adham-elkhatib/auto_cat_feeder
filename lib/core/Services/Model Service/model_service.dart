import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ModelService {
  static final ModelService _instance = ModelService._internal();

  factory ModelService() => _instance;

  ModelService._internal();

  late final Interpreter _interpreter;
  late final Map<String, Map<String, int>> _labelEncoders;
  late final List<double> _mean;
  late final List<double> _scale;
  late final List<String> _featureOrder;
  bool _initialized = false;

  Future<void> init({
    required String modelPath,
    required String labelEncoderPath,
    required String scalerPath,
  }) async {
    if (_initialized) return;

    _interpreter = await Interpreter.fromAsset(modelPath);

    final labelJson = await rootBundle.loadString(labelEncoderPath);
    _labelEncoders = Map<String, Map<String, int>>.from(
      json.decode(labelJson).map(
            (key, value) => MapEntry(
              key,
              Map<String, int>.from(value),
            ),
          ),
    );

    final scalerJson = await rootBundle.loadString(scalerPath);
    final scalerMap = json.decode(scalerJson);
    _mean = List<double>.from(scalerMap['mean']);
    _scale = List<double>.from(scalerMap['scale']);
    _featureOrder = List<String>.from(scalerMap['feature_names']);

    _initialized = true;
  }

  Future<double> predict(Map<String, dynamic> rawInput) async {
    if (!_initialized) throw Exception("ModelService not initialized");

    final encoded = _featureOrder.map((feature) {
      final value = rawInput[feature];

      if (value == null) {
        throw ArgumentError("Missing value for feature: $feature");
      }

      if (_labelEncoders.containsKey(feature)) {
        final encoder = _labelEncoders[feature]!;
        if (!encoder.containsKey(value.toString())) {
          throw ArgumentError(
              "Invalid value '$value' for encoded feature: $feature");
        }
        return encoder[value.toString()]!.toDouble();
      }

      return (value as num).toDouble();
    }).toList();

    final normalized = List.generate(encoded.length, (i) {
      return (encoded[i] - _mean[i]) / _scale[i];
    });

    final input = [normalized];
    final output = List.filled(1 * 1, 0.0).reshape([1, 1]);

    _interpreter.run(input, output);
    return output[0][0];
  }

  List<String> get expectedFeatures => _featureOrder;
}
