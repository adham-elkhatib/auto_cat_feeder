import '../errors/exceptions.dart';
import '../errors/failure.dart';

class FailureMapper {
  static Failure fromException(AppException exception) {
    if (exception is ServerException) {
      return ServerFailure(
        message: exception.message ?? "Server error occurred",
        code: exception.code,
        location: exception.location,
        original: exception,
        timestamp: exception.timestamp,
      );
    }

    if (exception is FirestoreException || exception is FirebaseExceptionApp) {
      return ServerFailure(
        message: exception.message ?? "Firebase backend error",
        code: exception.code,
        location: exception.location,
        original: exception,
        timestamp: exception.timestamp,
      );
    }
    if (exception is StorageException) {
      return StorageFailure(
        message: exception.message ?? "Storage error",
        location: exception.location,
        original: exception,
        timestamp: exception.timestamp,
      );
    }

    if (exception is MessagingException) {
      return MessagingFailure(
        message: exception.message ?? "Messaging error",
        location: exception.location,
        original: exception,
        timestamp: exception.timestamp,
      );
    }

    if (exception is AuthException) {
      return AuthFailure(
        message: exception.message ?? "Authentication failed",
        code: exception.code,
        location: exception.location,
        original: exception,
        timestamp: exception.timestamp,
      );
    }

    if (exception is NetworkException) {
      return NetworkFailure(
        message: exception.message ?? "No internet connection",
        location: exception.location,
        original: exception,
        timestamp: exception.timestamp,
      );
    }

    if (exception is CacheException) {
      return CacheFailure(
        message: exception.message ?? "Cache read/write failed",
        location: exception.location,
        original: exception,
        timestamp: exception.timestamp,
      );
    }

    if (exception is PlatformAppException) {
      return PlatformFailure(
        message: exception.message ?? "Platform error",
        location: exception.location,
        original: exception,
        timestamp: exception.timestamp,
      );
    }

    if (exception is TimeoutExceptionApp) {
      return TimeoutFailure(
        message: exception.message ?? "Connection timed out",
        location: exception.location,
        original: exception,
        timestamp: exception.timestamp,
      );
    }

    return UnknownFailure(
      message: exception.message ?? "Unexpected error",
      location: exception.location,
      original: exception,
      timestamp: exception.timestamp,
    );
  }
}
