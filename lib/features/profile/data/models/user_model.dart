import 'dart:convert';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String email,
    required String fName,
    required String lName,
    required String phoneNumber,
  }) : super(
          id: id,
          email: email,
          fName: fName,
          lName: lName,
          phoneNumber: phoneNumber,
        );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      fName: map['fName'] as String,
      lName: map['lName'] as String,
      phoneNumber: map['phone_number'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fName': fName,
      'lName': lName,
      'email': email,
      'phone_number': phoneNumber,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Helper: Create Model from pure Entity
  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      id: user.id,
      email: user.email,
      fName: user.fName,
      lName: user.lName,
      phoneNumber: user.phoneNumber,
    );
  }

  /// Helper: Convert Model to pure Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      fName: fName,
      lName: lName,
      phoneNumber: phoneNumber,
    );
  }
}
