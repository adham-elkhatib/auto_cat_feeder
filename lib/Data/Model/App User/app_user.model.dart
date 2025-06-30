import 'dart:convert';

class UserModel {
  String id;
  String email;
  String fName;
  String lName;
  String phoneNumber;

  UserModel({
    required this.id,
    required this.email,
    required this.fName,
    required this.lName,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fName': fName,
      'lName': lName,
      'email': email,
      'phone_number': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'],
      fName: map['fName'],
      lName: map['lName'],
      phoneNumber: map['phone_number'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
