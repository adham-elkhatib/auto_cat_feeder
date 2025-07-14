part of 'password_rules_cubit.dart';

class PasswordRulesState {
  final bool hasMinLength;
  final bool hasUpperCase;
  final bool hasLowerCase;
  final bool hasNumber;
  final bool hasSpecialChar;

  const PasswordRulesState({
    this.hasMinLength = false,
    this.hasUpperCase = false,
    this.hasLowerCase = false,
    this.hasNumber = false,
    this.hasSpecialChar = false,
  });
}
