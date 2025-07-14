import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Services/Error Handling/app_error.extension.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../../core/widgets/primary_button.dart';
import '../providers/auth_bloc.dart';

class ResetPasswordForm extends StatelessWidget {
  ResetPasswordForm({super.key});

  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          SnackbarHelper.showSuccess(
            context,
            title: LocaleKeys.auth_reset_password_success.tr(),
          );
          Navigator.pop(context);
        } else if (state is AuthFailure) {
          final error = state.error;

          if (error.shouldShow) {
            SnackbarHelper.showError(context, title: error.msg);
          } else {
            SnackbarHelper.showError(
              context,
              title: LocaleKeys.common_generic_error.tr(),
            );
          }
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.auth_reset_password_email_hint.tr(),
                    labelText: LocaleKeys.auth_reset_password_email.tr(),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.auth_reset_password_errors_empty_email
                          .tr();
                    }
                    String pattern =
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return LocaleKeys.auth_reset_password_errors_invalid_email
                          .tr();
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    title: state is AuthLoading
                        ? LocaleKeys.auth_reset_password_loading.tr()
                        : LocaleKeys.auth_reset_password_button.tr(),
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    ResetPasswordRequested(
                                      email: _emailController.text.trim(),
                                    ),
                                  );
                            }
                          },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
