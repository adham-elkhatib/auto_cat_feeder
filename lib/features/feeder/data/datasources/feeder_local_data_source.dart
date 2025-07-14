import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../models/feeder_model.dart';

abstract class FeederLocalDataSource {
  Future<void> cacheFeeder({required FeederModel? feederToCache});

  Future<FeederModel> getLastFeeder();
}

const cachedFeeder = 'CACHED_FEEDER';

class FeederLocalDataSourceImpl implements FeederLocalDataSource {
  final SharedPreferences sharedPreferences;

  FeederLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<FeederModel> getLastFeeder() {
    final jsonString = sharedPreferences.getString(cachedFeeder);

    if (jsonString != null) {
      return Future.value(FeederModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException(message: '');
    }
  }

  @override
  Future<void> cacheFeeder({required FeederModel? feederToCache}) async {
    if (feederToCache != null) {
      sharedPreferences.setString(
        cachedFeeder,
        json.encode(
          feederToCache.toJson(),
        ),
      );
    } else {
      throw CacheException(message: '');
    }
  }
}
