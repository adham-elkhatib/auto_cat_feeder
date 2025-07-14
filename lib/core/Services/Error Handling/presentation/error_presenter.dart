import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../../App/app.service.dart';
import '../../Logging/logging.service.dart';
import '../models/app_error.dart';

/// Abstract base presenter used for displaying or reporting errors.
abstract class ErrorPresenter {
  void present(AppError error);
}

/// Presenter that shows a Snackbar using the provided BuildContext,
/// and logs the error to Logger + Firebase (only in production).
class FirebaseErrorPresenter implements ErrorPresenter {
  final BuildContext context;

  FirebaseErrorPresenter(this.context);

  @override
  void present(AppError error) {
    final msg = error.msg ?? "An unexpected error occurred.";

    if (error.type == AppErrorType.presentable ||
        error.type == AppErrorType.generic) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }

    LoggingService.log(
      "[AppError] ${msg.tr()}",
      level: Level.error,
      error: error,
    );

    if (App.env == AppEnvironment.prod && error.type == AppErrorType.fatal) {
      FirebaseCrashlytics.instance.recordError(
        error,
        null,
        reason: msg,
        information: [
          'Code: ${error.code}',
          'Location: ${error.location}',
          'Type: ${error.type.name}',
        ],
      );
    }
  }
}

/// Default presenter used in core logic layers (no UI), logs to logger + crashlytics if in production.
class DefaultErrorPresenter implements ErrorPresenter {
  @override
  void present(AppError error) {
    final msg = error.msg ?? "Unhandled error";

    LoggingService.log(
      "[AppError] ${msg.tr()}",
      // todo implement more precise error leveling
      level: Level.error,
      error: error,
    );

    if (App.env == AppEnvironment.prod && error.type == AppErrorType.fatal) {
      FirebaseCrashlytics.instance.recordError(
        error,
        StackTrace.current,
        reason: msg.tr(),
        information: [
          'Code: ${error.code}',
          'Location: ${error.location}',
          'Type: ${error.type.name}',
        ],
      );
    }
  }
}

/// Lightweight presenter for testing or CLI/debug tools — logs to console only.
class LoggerOnlyPresenter implements ErrorPresenter {
  @override
  void present(AppError error) {
    LoggingService.log(
      "[AppError] ${error.msg.tr() ?? 'Unknown'}",
      level: Level.warning,
      error: error,
    );
  }
}
