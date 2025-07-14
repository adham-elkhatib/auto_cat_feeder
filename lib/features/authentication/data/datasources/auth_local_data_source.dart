import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/Services/Error Handling/errors/exceptions.dart';
import '../models/auth_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheAuthData({required AuthModel authToCache});

  Future<void> clearCachedAuthData();

  Future<bool> isLoggedIn();
}

const cachedAuth = 'CACHED_AUTH';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheAuthData({required AuthModel authToCache}) async {
    final authJson = authToCache.toJson();
    final success = await sharedPreferences.setString(cachedAuth, authJson);
    await sharedPreferences.setBool('is_first_time', false);

    if (!success) {
      throw CacheException(message: 'Failed to cache auth data');
    }
  }

  @override
  Future<void> clearCachedAuthData() async {
    final success = await sharedPreferences.remove(cachedAuth);

    if (!success) {
      throw CacheException(message: 'Failed to clear cached auth');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final jsonString = sharedPreferences.getString(cachedAuth);
    return jsonString != null;
  }
}
