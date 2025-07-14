// todo implement params
class ProfileParams {
  final String id;

  const ProfileParams({
    required this.id,
  });
}

class UpdateProfileParams {
  final String id;
  final String email;
  final String fName;
  final String lName;
  final String phoneNumber;

  const UpdateProfileParams({
    required this.id,
    required this.email,
    required this.fName,
    required this.lName,
    required this.phoneNumber,
  });
}

class CreateProfileParams {
  final String id;
  final String email;
  final String fName;
  final String lName;
  final String phoneNumber;

  const CreateProfileParams({
    required this.id,
    required this.email,
    required this.fName,
    required this.lName,
    required this.phoneNumber,
  });
}
