//t2 Core Packages Imports
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../authentication/presentation/pages/landing_screen.dart';
import '../providers/profile_bloc.dart';
import '../widgets/profile_bottom_nav.dart';
import '../widgets/profile_form.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class ProfileScreen extends StatefulWidget {
  //SECTION - Widget Arguments

  //!SECTION
  //
  const ProfileScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(const GetProfileEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LandingScreen()),
            (_) => false,
          );
        } else if (state is ProfileLoaded) {
          _fNameController.text = state.user.fName;
          _lNameController.text = state.user.lName;
          _emailController.text = state.user.email;
          _phoneNumberController.text = state.user.phoneNumber;
        } else if (state is ProfileSuccess) {
          SnackbarHelper.showTemplated(
            context,
            title: LocaleKeys.profile_messages_update_success.tr(),
          );
          Navigator.pop(context);
        } else if (state is ProfileFailure) {
          SnackbarHelper.showError(
            context,
            title: state.message,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.profile_title).tr(),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                context.read<ProfileBloc>().add(const LogoutEvent());
              },
              child: Text(
                LocaleKeys.profile_sign_out.tr(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            )
          ],
        ),
        body: ProfileForm(
          formKey: _formKey,
          lNameController: _lNameController,
          phoneNumberController: _phoneNumberController,
          emailController: _emailController,
          fNameController: _fNameController,
        ),
        bottomNavigationBar: ProfileBottomNav(
          formKey: _formKey,
          lNameController: _lNameController,
          phoneNumberController: _phoneNumberController,
          emailController: _emailController,
          fNameController: _fNameController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
