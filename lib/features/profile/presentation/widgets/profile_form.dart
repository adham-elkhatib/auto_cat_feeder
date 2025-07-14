import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../../core/widgets/section_title.dart';
import '../providers/profile_bloc.dart';

class ProfileForm extends StatelessWidget {
  final TextEditingController fNameController;
  final TextEditingController lNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final GlobalKey<FormState> formKey;

  const ProfileForm({
    super.key,
    required this.fNameController,
    required this.lNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileFailure) {
          SnackbarHelper.showError(
            context,
            title: state.message.tr(),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        } else if (state is ProfileFailure) {
          return Center(
            child: Text(LocaleKeys.common_fallback_error.tr()),
          );
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SectionTitle(title: LocaleKeys.profile_account_details.tr()),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: fNameController,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.profile_first_name.tr(),
                      labelText: LocaleKeys.profile_first_name.tr(),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.profile_errors_empty_first_name.tr();
                      } else if (value.length < 3) {
                        return LocaleKeys.profile_errors_short_first_name.tr();
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: lNameController,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.profile_last_name.tr(),
                      labelText: LocaleKeys.profile_last_name.tr(),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.profile_errors_empty_last_name.tr();
                      } else if (value.length < 3) {
                        return LocaleKeys.profile_errors_short_last_name.tr();
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.profile_email.tr(),
                      labelText: LocaleKeys.profile_email.tr(),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  SectionTitle(title: LocaleKeys.profile_personal_info.tr()),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.profile_phone.tr(),
                      labelText: LocaleKeys.profile_phone.tr(),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.profile_errors_empty_phone.tr();
                      }
                      if (!RegExp(r'^05\d{8}$').hasMatch(value)) {
                        return LocaleKeys.profile_errors_invalid_phone.tr();
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
