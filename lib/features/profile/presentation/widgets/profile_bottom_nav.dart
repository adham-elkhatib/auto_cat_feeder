import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/params/profile/profile_params.dart';
import '../../../../core/widgets/primary_button.dart';
import '../providers/profile_bloc.dart';

class ProfileBottomNav extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fNameController;
  final TextEditingController lNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;

  const ProfileBottomNav({
    super.key,
    required this.formKey,
    required this.fNameController,
    required this.lNameController,
    required this.emailController,
    required this.phoneNumberController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        String userId = '';

        if (state is ProfileLoaded) {
          userId = state.user.id;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 42),
          child: PrimaryButton(
            onPressed: state is ProfileLoading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      context.read<ProfileBloc>().add(
                            UpdateProfileEvent(
                              params: UpdateProfileParams(
                                id: userId,
                                email: emailController.text,
                                fName: fNameController.text,
                                lName: lNameController.text,
                                phoneNumber: phoneNumberController.text,
                              ),
                            ),
                          );
                    }
                  },
            color: Theme.of(context).colorScheme.primary,
            title: state is ProfileLoading
                ? LocaleKeys.profile_loading.tr()
                : LocaleKeys.profile_button.tr(),
          ),
        );
      },
    );
  }
}
