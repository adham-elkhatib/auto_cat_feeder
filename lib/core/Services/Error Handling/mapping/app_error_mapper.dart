import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../errors/failure.dart';
import '../models/app_error.dart';
import 'error_map.dart';

class AppErrorMapper {
  static AppError fromFailure(Failure failure) {
    final timestamp = failure.timestamp;
    final location = failure.location;
    final code = _resolveErrorCode(failure);

    // ✅ 1. Check if code exists in errorMap
    final mapped = errorMap[code];
    if (mapped != null) {
      return mapped.copyWith(
        location: location,
        timestamp: timestamp,
      );
    }

    // ❌ 2. Fallback if no map match found
    return AppError.presentable(
      code,
      failure.message,
      location: location,
      timestamp: timestamp,
    );
  }

  /// Returns a standard key like:
  /// - firebase_auth/invalid-credential
  /// - dio/no-internet
  /// - c/permission_denied
  static String _resolveErrorCode(Failure failure) {
    final error = _unwrap(failure.original ?? failure);

    if (error is FirebaseAuthException) {
      return "firebase_auth/${error.code}";
    } else if (error is FirebaseException) {
      return "${error.plugin}/${error.code}";
    } else if (error is DioException) {
      return 'dio/unknown';
    }

    if (failure is AuthFailure)
      return 'firebase_auth/${failure.code ?? "unknown"}';

    if (failure is ServerFailure) return 'dio/bad-response';
    if (failure is NetworkFailure) return 'dio/no-internet';
    if (failure is CacheFailure) return 'c/cache-failure';
    if (failure is PermissionFailure) return 'c/permission_denied';

    return 'unknown';
  }

  static dynamic _unwrap(dynamic error) {
    var current = error;
    while (current != null && current is Failure || current is Exception) {
      if (current is Failure && current.original != null) {
        current = current.original;
      } else if (current is Exception &&
          current is! FirebaseAuthException &&
          current is! FirebaseException) {
        try {
          final original = (current as dynamic).original;
          if (original != null) {
            current = original;
          } else {
            break;
          }
        } catch (_) {
          break;
        }
      } else {
        break;
      }
    }
    return current;
  }
}
