import 'models/app_error.dart';

extension AppErrorX on AppError {
  /// Whether this error should be shown in UI (Snackbar, Dialog, etc.)
  bool get shouldShow =>
      type == AppErrorType.presentable || type == AppErrorType.generic;

  /// Whether this error is fatal and should trigger reporting/crash logging
  bool get shouldReport => type == AppErrorType.fatal;
}
