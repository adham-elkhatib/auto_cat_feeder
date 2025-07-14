/// Base class for failures used in Either<Failure, Success>
abstract class Failure {
  final String message;
  final int? code;
  final String? location;
  final dynamic original;
  final DateTime timestamp;

  Failure({
    required this.message,
    this.code,
    this.location,
    this.original,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  String toString() {
    return "$runtimeType at ${location ?? 'unknown'}: $message";
  }
}

class ServerFailure extends Failure {
  ServerFailure({
    required String message,
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

class StorageFailure extends Failure {
  StorageFailure({
    required String message,
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          message: message,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

class MessagingFailure extends Failure {
  MessagingFailure({
    required String message,
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          message: message,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

class CacheFailure extends Failure {
  CacheFailure({
    required String message,
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          message: message,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

class NetworkFailure extends Failure {
  NetworkFailure({
    required String message,
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          message: message,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

class AuthFailure extends Failure {
  AuthFailure({
    required String message,
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

class TimeoutFailure extends Failure {
  TimeoutFailure({
    required String message,
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          message: message,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

class PlatformFailure extends Failure {
  PlatformFailure({
    required String message,
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          message: message,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

class PermissionFailure extends Failure {
  PermissionFailure({
    required String message,
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          message: message,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}

class UnknownFailure extends Failure {
  UnknownFailure({
    String message = "Unexpected error",
    String? location,
    dynamic original,
    DateTime? timestamp,
  }) : super(
          message: message,
          location: location,
          original: original,
          timestamp: timestamp,
        );
}
