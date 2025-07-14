import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../errors/exceptions.dart';

class ErrorMapper {
  static AppException map(dynamic error, StackTrace? stackTrace,
      {String? location}) {
    final timestamp = DateTime.now();

    if (error is FirebaseAuthException) {
      return AuthException(
        message: error.message,
        code: _tryParseCode(error.code),
        location: location,
        original: error,
        timestamp: timestamp,
      );
    }

    if (error is FirebaseException) {
      switch (error.plugin) {
        case 'cloud_firestore':
          return FirestoreException(
            message: error.message,
            location: location,
            original: error,
            timestamp: timestamp,
          );
        case 'firebase_storage':
          return StorageException(
            message: error.message,
            location: location,
            original: error,
            timestamp: timestamp,
          );
        case 'firebase_messaging':
          return MessagingException(
            message: error.message,
            location: location,
            original: error,
            timestamp: timestamp,
          );
        default:
          return FirebaseExceptionApp(
            plugin: error.plugin,
            message: error.message,
            location: location,
            original: error,
            timestamp: timestamp,
          );
      }
    }

    if (error is DioException) {
      return ServerException(
        message: error.message,
        code: error.response?.statusCode,
        location: location,
        original: error,
        timestamp: timestamp,
      );
    }

    if (error is SocketException) {
      return NetworkException(
        message: "No internet connection",
        location: location,
        original: error,
        timestamp: timestamp,
      );
    }

    if (error is TimeoutException) {
      return TimeoutExceptionApp(
        message: "Request timed out",
        location: location,
        original: error,
        timestamp: timestamp,
      );
    }

    if (error is PlatformException) {
      return PlatformAppException(
        message: error.message,
        location: location,
        original: error,
        timestamp: timestamp,
      );
    }

    if (error is AppException) return error;

    return UnknownAppException(
      message: error.toString(),
      location: location,
      original: error,
      timestamp: timestamp,
    );
  }

  static int? _tryParseCode(String? code) {
    try {
      return code != null ? int.tryParse(code) : null;
    } catch (_) {
      return null;
    }
  }
}
