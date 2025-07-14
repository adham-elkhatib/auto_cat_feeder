import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../models/user_model.dart';

abstract class ProfileLocalDataSource {
  Future<void> cacheProfile({required UserModel? profileToCache});

  Future<UserModel> getLastProfile();
}

const cachedProfile = 'CACHED_PROFILE';

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProfileLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel> getLastProfile() {
    final jsonString = sharedPreferences.getString(cachedProfile);

    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException(message: '');
    }
  }

  @override
  Future<void> cacheProfile({required UserModel? profileToCache}) async {
    if (profileToCache != null) {
      sharedPreferences.setString(
        cachedProfile,
        json.encode(
          profileToCache.toJson(),
        ),
      );
    } else {
      throw CacheException(message: '');
    }
  }
}
