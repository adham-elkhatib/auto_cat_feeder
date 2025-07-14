import 'dart:convert';

import '../../domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required String uid,
    required String authenticationToken,
    required String refreshToken,
    required String provider,
  }) : super(
          uid: uid,
          authenticationToken: authenticationToken,
          refreshToken: refreshToken,
          provider: provider,
        );

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      uid: map['uid'] as String,
      authenticationToken: map['authenticationToken'] as String,
      refreshToken: map['refreshToken'] as String,
      provider: map['provider'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'authenticationToken': authenticationToken,
      'refreshToken': refreshToken,
      'provider': provider,
    };
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory AuthModel.fromEntity(AuthEntity entity) {
    return AuthModel(
      uid: entity.uid,
      authenticationToken: entity.authenticationToken,
      refreshToken: entity.refreshToken,
      provider: entity.provider,
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      uid: uid,
      authenticationToken: authenticationToken,
      refreshToken: refreshToken,
      provider: provider,
    );
  }
}
