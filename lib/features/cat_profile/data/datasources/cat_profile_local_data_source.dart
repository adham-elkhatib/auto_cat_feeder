import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../models/cat_model.dart';

abstract class CatLocalDataSource {
  Future<void> cacheCat({required CatModel? catToCache});

  Future<CatModel> getLastCat();

  Future<void> fistTime();
}

const cachedCat = 'CACHED_CAT';

class CatLocalDataSourceImpl implements CatLocalDataSource {
  final SharedPreferences sharedPreferences;

  CatLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<CatModel> getLastCat() {
    final jsonString = sharedPreferences.getString(cachedCat);

    if (jsonString != null) {
      return Future.value(CatModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException(message: 'No cached cat found');
    }
  }

  @override
  Future<void> cacheCat({required CatModel? catToCache}) async {
    if (catToCache != null) {
      sharedPreferences.setString(
        cachedCat,
        json.encode(
          catToCache.toJson(),
        ),
      );
    } else {
      throw CacheException(message: '');
    }
  }

  @override
  Future<void> fistTime() async {
    await sharedPreferences.setBool('is_first_time', false);
  }
}
