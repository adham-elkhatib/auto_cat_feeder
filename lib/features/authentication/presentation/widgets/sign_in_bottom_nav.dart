import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_controller/form_controller.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/widgets/primary_button.dart';
import '../pages/sign_up_screen.dart';
import '../providers/auth_bloc.dart';

class SignInBottomNav extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final FormController formController;

  const SignInBottomNav({
    super.key,
    required this.formKey,
    required this.formController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  LoginRequested(
                                    email: formController
                                        .controller("email")
                                        .text
                                        .trim(),
                                    password: formController
                                        .controller("password")
                                        .text,
                                  ),
                                );
                          }
                        },
                  title: state is AuthLoading
                      ? LocaleKeys.auth_sign_in_loading.tr()
                      : LocaleKeys.auth_sign_in_button.tr(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(LocaleKeys.auth_sign_in_create_account_link.tr()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
