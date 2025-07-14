import 'errors/failure.dart';
import 'mapping/app_error_mapper.dart';
import 'mapping/error_mapper.dart';
import 'mapping/failure_mapper.dart';
import 'presentation/error_presenter.dart';

typedef AsyncCallback = Future<void> Function();

class ErrorHandlingService {
  const ErrorHandlingService._();

  /// Use this method to wrap async functions and handle any unexpected exceptions.
  static Future<void> protect(
    AsyncCallback process, {
    required Function(Failure failure) onFailure,
    String? location,
  }) async {
    try {
      await process();
    } catch (error, stackTrace) {
      handle(
        error,
        stackTrace,
        location: location,
        onFailure: onFailure,
      );
    }
  }

  /// Handles error from any source, maps it, logs it, and returns a Failure
  static Failure handle(
    Object error,
    StackTrace stackTrace, {
    String? location,
    Function(Failure failure)? onFailure,
  }) {
    // 1. Convert raw error to AppException
    final appException = ErrorMapper.map(error, stackTrace, location: location);

    // 2. Convert AppException to domain-level Failure
    final failure = FailureMapper.fromException(appException);

    // 3. Convert Failure to AppError for UI/Logging
    final appError = AppErrorMapper.fromFailure(failure);

    // 4. Present error in UI / Logger / Crashlytics
    DefaultErrorPresenter().present(appError);

    // 5. Trigger any fallback handler (e.g., Bloc emit or callback)
    if (onFailure != null) {
      onFailure(failure);
    }

    return failure;
  }
}
