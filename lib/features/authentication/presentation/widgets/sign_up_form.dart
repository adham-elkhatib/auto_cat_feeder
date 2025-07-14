import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Services/Error Handling/app_error.extension.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../on_boarding/presentation/pages/on_boarding_page.dart';
import '../providers/auth_bloc.dart';
import '../providers/password_rules_cubit.dart';

class SignUpForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fNameController;
  final TextEditingController lNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneNumberController;

  const SignUpForm({
    super.key,
    required this.formKey,
    required this.fNameController,
    required this.lNameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneNumberController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const OnBoardingPage()),
            (route) => false,
          );
        } else if (state is AuthFailure) {
          final error = state.error;

          if (error.shouldShow) {
            SnackbarHelper.showError(context, title: error.msg);
          } else {
            SnackbarHelper.showError(
              context,
              title: "Something went wrong. Please try again.",
            );
          }
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.auth_sign_up_account_info.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: fNameController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.auth_sign_up_first_name.tr(),
                        labelText: LocaleKeys.auth_sign_up_first_name.tr(),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.auth_sign_up_errors_empty_first_name
                              .tr();
                        } else if (value.length < 3) {
                          return LocaleKeys.auth_sign_up_errors_short_first_name
                              .tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: lNameController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.auth_sign_up_last_name.tr(),
                        labelText: LocaleKeys.auth_sign_up_last_name.tr(),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.auth_sign_up_errors_empty_last_name
                              .tr();
                        } else if (value.length < 3) {
                          return LocaleKeys.auth_sign_up_errors_short_last_name
                              .tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.auth_sign_up_email.tr(),
                        hintText: LocaleKeys.auth_sign_up_email_hint.tr(),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.auth_sign_up_errors_empty_email
                              .tr();
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return LocaleKeys.auth_sign_up_errors_invalid_email
                              .tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.auth_sign_up_password.tr(),
                        labelText: LocaleKeys.auth_sign_up_password.tr(),
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        context.read<PasswordRulesCubit>().check(value);
                      },
                      validator: (value) {
                        final state = context.read<PasswordRulesCubit>().state;
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.auth_sign_up_errors_empty_password
                              .tr();
                        } else if (!state.hasMinLength) {
                          return LocaleKeys.auth_sign_up_errors_min_length.tr();
                        } else if (!state.hasUpperCase) {
                          return LocaleKeys.auth_sign_up_errors_uppercase.tr();
                        } else if (!state.hasLowerCase) {
                          return LocaleKeys.auth_sign_up_errors_lowercase.tr();
                        } else if (!state.hasNumber) {
                          return LocaleKeys.auth_sign_up_errors_number.tr();
                        } else if (!state.hasSpecialChar) {
                          return LocaleKeys.auth_sign_up_errors_special_char
                              .tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<PasswordRulesCubit, PasswordRulesState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ruleItem(state.hasMinLength,
                                LocaleKeys.auth_sign_up_errors_min_length.tr()),
                            _ruleItem(state.hasUpperCase,
                                LocaleKeys.auth_sign_up_errors_uppercase.tr()),
                            _ruleItem(state.hasLowerCase,
                                LocaleKeys.auth_sign_up_errors_lowercase.tr()),
                            _ruleItem(state.hasNumber,
                                LocaleKeys.auth_sign_up_errors_number.tr()),
                            _ruleItem(
                                state.hasSpecialChar,
                                LocaleKeys.auth_sign_up_errors_special_char
                                    .tr()),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      LocaleKeys.auth_sign_up_general_info.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.auth_sign_up_phone_hint.tr(),
                        labelText: LocaleKeys.auth_sign_up_phone.tr(),
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.auth_sign_up_errors_empty_phone
                              .tr();
                        }
                        if (!RegExp(r'^05\d{8}$').hasMatch(value)) {
                          return LocaleKeys.auth_sign_up_errors_invalid_phone
                              .tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _ruleItem(bool condition, String text) {
    return Row(
      children: [
        Icon(
          condition ? Icons.check : Icons.close,
          color: condition ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
