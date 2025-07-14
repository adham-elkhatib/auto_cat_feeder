import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_controller/form_controller.dart';

import '../../../../core/Services/Error Handling/app_error.extension.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../pages/reset_password_screen.dart';
import '../providers/auth_bloc.dart';

class SignInForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final FormController formController;

  const SignInForm(
      {super.key, required this.formKey, required this.formController});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        } else if (state is AuthFailure) {
          final error = state.error;

          if (error.shouldShow) {
            SnackbarHelper.showError(context, title: tr(error.msg));
          } else {
            SnackbarHelper.showError(
              context,
              title: LocaleKeys.common_generic_error.tr(),
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
                    TextFormField(
                      controller: formController.controller("email"),
                      decoration: InputDecoration(
                        labelText: LocaleKeys.auth_sign_in_email.tr(),
                        hintText: LocaleKeys.auth_sign_in_email_hint.tr(),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.auth_sign_in_errors_empty_email
                              .tr();
                        }
                        String pattern =
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return LocaleKeys.auth_sign_in_errors_invalid_email
                              .tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: formController.controller("password"),
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.auth_sign_in_errors_empty_password
                              .tr();
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => const ResetPasswordScreen(),
                            ),
                          );
                        },
                        child:
                            Text(LocaleKeys.auth_sign_in_forgot_password.tr()),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
