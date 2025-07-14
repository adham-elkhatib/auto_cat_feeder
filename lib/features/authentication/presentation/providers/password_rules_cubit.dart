import 'package:bloc/bloc.dart';

part 'password_rules_state.dart';

class PasswordRulesCubit extends Cubit<PasswordRulesState> {
  PasswordRulesCubit() : super(const PasswordRulesState());

  void check(String password) {
    emit(
      PasswordRulesState(
        hasMinLength: password.length >= 8,
        hasUpperCase: RegExp(r'[A-Z]').hasMatch(password),
        hasLowerCase: RegExp(r'[a-z]').hasMatch(password),
        hasNumber: RegExp(r'[0-9]').hasMatch(password),
        hasSpecialChar: RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password),
      ),
    );
  }
}
