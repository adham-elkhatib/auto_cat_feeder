import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/tertiary_button.dart';
import '../pages/sign_in_screen.dart';
import '../providers/auth_bloc.dart';

class SignUpBottomNav extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController fNameController;
  final TextEditingController lNameController;
  final TextEditingController phoneNumberController;

  const SignUpBottomNav({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.fNameController,
    required this.lNameController,
    required this.phoneNumberController,
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
                          if (formKey.currentState?.validate() ?? false) {
                            context.read<AuthBloc>().add(
                                  RegisterRequested(
                                    email: emailController.text.trim(),
                                    password: passwordController.text,
                                    phoneNumber: phoneNumberController.text,
                                    fName: fNameController.text,
                                    lName: lNameController.text,
                                  ),
                                );
                          }
                        },
                  title: state is AuthLoading
                      ? LocaleKeys.auth_sign_up_loading.tr()
                      : LocaleKeys.auth_sign_up_button.tr(),
                ),
              ),
              const SizedBox(height: 8),
              TertiaryButton(
                title: LocaleKeys.auth_sign_up_back_to_signin.tr(),
                onPressed: state is AuthLoading
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const SignInScreen(),
                          ),
                        );
                      },
              ),
            ],
          ),
        );
      },
    );
  }
}
