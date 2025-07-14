class AuthEntity {
  final String uid;
  final String authenticationToken;
  final String refreshToken;
  final String provider;

  const AuthEntity({
    required this.uid,
    required this.authenticationToken,
    required this.refreshToken,
    required this.provider,
  });
}
