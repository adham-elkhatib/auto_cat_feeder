/// Base class for application-specific exceptions
abstract class AppException implements Exception {
  final String? message;
  final int? code;
  final String? location;
  final dynamic original;
  final DateTime timestamp;

  AppException({
    this.message,
    this.code,
    this.location,
    this.original,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  String toString() {
    return "$runtimeType at ${location ?? 'unknown'}: ${message ?? 'No message'}";
  }
}

/// Thrown when a server-side error occurs (e.g. 500, DioError, etc.)
class ServerException extends AppException {
  ServerException({
    String? message,
    int? code,
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          message: message,
          code: code,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

class FirebaseExceptionApp extends AppException {
  final String plugin;

  FirebaseExceptionApp({
    required this.plugin,
    String? message,
    int? code,
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          message: message,
          code: code,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

class FirestoreException extends FirebaseExceptionApp {
  FirestoreException({
    String? message,
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          plugin: 'cloud_firestore',
          message: message,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

class StorageException extends FirebaseExceptionApp {
  StorageException({
    String? message,
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          plugin: 'firebase_storage',
          message: message,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

class MessagingException extends FirebaseExceptionApp {
  MessagingException({
    String? message,
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          plugin: 'firebase_messaging',
          message: message,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

/// Thrown when an authentication-specific issue happens
class AuthException extends AppException {
  AuthException({
    String? message,
    int? code,
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          message: message,
          code: code,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

/// Thrown when there's no internet or network failure
class NetworkException extends AppException {
  NetworkException({
    String? message,
    int? code,
    dynamic original,
    String? location,
    DateTime? timestamp,
  }) : super(
          message: message,
          code: code,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

/// Thrown when local storage fails (e.g. SharedPreferences, Hive)
class CacheException extends AppException {
  CacheException({
    required String message,
    dynamic original,
    String? location,
    DateTime? timestamp,
  }) : super(
          message: message,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

/// Thrown for platform-specific errors (e.g. permissions, channels)
class PlatformAppException extends AppException {
  PlatformAppException({
    String? message,
    dynamic original,
    String? location,
    DateTime? timestamp,
  }) : super(
          message: message,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

/// Thrown when timeout occurs (e.g. connection / read timeout)
class TimeoutExceptionApp extends AppException {
  TimeoutExceptionApp({
    String? message,
    dynamic original,
    String? location,
    DateTime? timestamp,
  }) : super(
          message: message,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

/// Unknown or unexpected exception fallback
class UnknownAppException extends AppException {
  UnknownAppException({
    String? message,
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          message: message,
          original: original,
          location: location,
          timestamp: timestamp,
        );
}
