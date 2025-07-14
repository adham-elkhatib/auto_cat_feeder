import 'dart:convert';

enum AppErrorType {
  ignored,
  generic,
  presentable,
  fatal,
}

class AppError {
  final AppErrorType type;
  final String code;
  final DateTime timestamp;

  final String? templateMsg;
  final List<String>? variables;

  final String? location;

  AppError({
    required this.type,
    required this.code,
    required this.timestamp,
    this.templateMsg,
    this.variables,
    this.location,
  });

  factory AppError.presentable(
    String code,
    String templateMsg, {
    List<String>? variables,
    String? location,
    DateTime? timestamp,
  }) {
    return AppError(
      type: AppErrorType.presentable,
      code: code,
      templateMsg: templateMsg,
      variables: variables,
      location: location,
      timestamp: timestamp ?? DateTime.now(),
    );
  }

  factory AppError.generic({
    String code = 'Generic',
    String? templateMsg,
    List<String>? variables,
    String? location,
    DateTime? timestamp,
  }) {
    return AppError(
      type: AppErrorType.generic,
      code: code,
      templateMsg: templateMsg,
      variables: variables,
      location: location,
      timestamp: timestamp ?? DateTime.now(),
    );
  }

  factory AppError.fatal(
    String code,
    String templateMsg, {
    List<String>? variables,
    String? location,
    DateTime? timestamp,
  }) {
    return AppError(
      type: AppErrorType.fatal,
      code: code,
      templateMsg: templateMsg,
      variables: variables,
      location: location,
      timestamp: timestamp ?? DateTime.now(),
    );
  }

  factory AppError.ignored({
    String code = 'Ignored',
    String? templateMsg,
    List<String>? variables,
    String? location,
    DateTime? timestamp,
  }) {
    return AppError(
      type: AppErrorType.ignored,
      code: code,
      templateMsg: templateMsg,
      variables: variables,
      location: location,
      timestamp: timestamp ?? DateTime.now(),
    );
  }

  String get msg {
    if (templateMsg == null) return "Unexpected error";
    var result = templateMsg!;
    if (variables != null) {
      for (final variable in variables!) {
        result = result.replaceFirst("{}", variable);
      }
    }
    return result;
  }

  AppError copyWith({
    AppErrorType? type,
    String? code,
    DateTime? timestamp,
    String? templateMsg,
    List<String>? variables,
    String? location,
  }) {
    return AppError(
      type: type ?? this.type,
      code: code ?? this.code,
      timestamp: timestamp ?? this.timestamp,
      templateMsg: templateMsg ?? this.templateMsg,
      variables: variables ?? this.variables,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.index,
      'code': code,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'templateMsg': templateMsg,
      'variables': variables,
      'location': location,
    };
  }

  factory AppError.fromMap(Map<String, dynamic> map) {
    return AppError(
      type: AppErrorType.values[map['type']],
      code: map['code'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      templateMsg: map['templateMsg'],
      variables:
          map['variables'] != null ? List<String>.from(map['variables']) : null,
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppError.fromJson(String source) =>
      AppError.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppError(type: $type, code: $code, timestamp: $timestamp, msg: $msg, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppError &&
        other.type == type &&
        other.code == code &&
        other.timestamp == timestamp &&
        other.templateMsg == templateMsg &&
        listEquals(other.variables, variables) &&
        other.location == location;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        code.hashCode ^
        timestamp.hashCode ^
        templateMsg.hashCode ^
        variables.hashCode ^
        location.hashCode;
  }
}

bool listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null || b == null) return a == b;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
