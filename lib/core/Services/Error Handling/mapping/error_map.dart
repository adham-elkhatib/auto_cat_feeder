import '../models/app_error.dart';

/// Shortcut to define presentable errors
AppError p(String code, String key) => AppError.presentable(code, key);

/// Shortcut to define ignored errors
AppError i(String code) => AppError.ignored(code: code);

final Map<String, AppError> errorMap = {
  // 🔐 Firebase Authentication
  "firebase_auth/invalid-email": p("Auth501", "auth.errors.invalid_email"),
  "firebase_auth/invalid-credential":
      p("Auth403", "auth.errors.invalid_credential"),
  "firebase_auth/email-already-in-use":
      p("Auth405", "auth.errors.email_in_use"),
  "firebase_auth/user-not-found": p("Auth404", "auth.errors.user_not_found"),
  "firebase_auth/wrong-password": p("Auth400", "auth.errors.wrong_password"),
  "firebase_auth/user-disabled": p("Auth406", "auth.errors.user_disabled"),
  "firebase_auth/operation-not-allowed":
      p("Auth407", "auth.errors.not_allowed"),
  "firebase_auth/weak-password": p("Auth408", "auth.errors.weak_password"),
  "firebase_auth/too-many-requests":
      p("Auth429", "auth.errors.too_many_requests"),
  "firebase_auth/network-request-failed":
      p("Auth503", "auth.errors.network_error"),

  // 🧩 Firestore
  "cloud_firestore/unavailable": i("FS001"),
  "cloud_firestore/aborted": p("FS002", "fs.aborted"),
  "cloud_firestore/permission-denied": p("FS003", "fs.permission_denied"),
  "cloud_firestore/not-found": p("FS004", "fs.not_found"),
  "cloud_firestore/failed-precondition": p("FS005", "fs.failed_precondition"),
  "cloud_firestore/cancelled": p("FS006", "fs.cancelled"),
  "cloud_firestore/data-loss": p("FS007", "fs.data_loss"),
  "cloud_firestore/already-exists": p("FS008", "fs.already_exists"),
  "c/firestore-item-exists": p("FS009", "fs.item_exists"),

  // 🗄️ Firebase Storage
  "firebase_storage/object-not-found": p("ST001", "storage.not_found"),
  "firebase_storage/unauthorized": p("ST002", "storage.unauthorized"),
  "firebase_storage/canceled": p("ST003", "storage.cancelled"),
  "firebase_storage/unknown": p("ST004", "storage.unknown"),

  // 📩 Firebase Messaging
  "firebase_messaging/invalid-argument": p("MSG001", "msg.invalid_argument"),
  "firebase_messaging/unauthorized": p("MSG002", "msg.unauthorized"),
  "firebase_messaging/internal-error": p("MSG003", "msg.internal_error"),
  "firebase_messaging/unknown": p("MSG004", "msg.unknown"),

  // 🌐 Firebase RTDB
  "firebase_database/permission-denied": p("RTDB001", "rtdb.permission_denied"),
  "firebase_database/disconnected": p("RTDB002", "rtdb.disconnected"),
  "firebase_database/network-error": p("RTDB003", "rtdb.network_error"),
  "firebase_database/timeout": p("RTDB004", "rtdb.timeout"),
  "firebase_database/operation-failed": p("RTDB005", "rtdb.operation_failed"),

  // 🌍 Dio
  "dio/bad-response": p("Dio400", "dio.bad_response"),
  "dio/connection-timeout": p("Dio408", "dio.connection_timeout"),
  "dio/receive-timeout": p("Dio409", "dio.receive_timeout"),
  "dio/send-timeout": p("Dio410", "dio.send_timeout"),
  "dio/cancel": p("Dio499", "dio.cancelled"),
  "dio/no-internet": p("Dio503", "dio.no_internet"),
  "dio/unknown": p("Dio500", "dio.unknown_error"),

  // 📛 Permissions
  "c/permission_denied": p("PERM001", "perm.denied"),
  "c/permission_denied_permanently": p("PERM002", "perm.denied_permanently"),
};
