//t2 Core Packages Imports
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../providers/password_rules_cubit.dart';
import '../widgets/sign_up_bottom_nav.dart';
import '../widgets/sign_up_form.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class SignUpScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const SignUpScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.auth_sign_up_title.tr(),
        ),
      ),
      body: BlocProvider(
        create: (_) => PasswordRulesCubit(),
        child: SignUpForm(
          formKey: formKey,
          emailController: _emailController,
          passwordController: _passwordController,
          fNameController: _fNameController,
          lNameController: _lNameController,
          phoneNumberController: _phoneNumberController,
        ),
      ),
      bottomNavigationBar: SignUpBottomNav(
        formKey: formKey,
        emailController: _emailController,
        passwordController: _passwordController,
        fNameController: _fNameController,
        lNameController: _lNameController,
        phoneNumberController: _phoneNumberController,
      ),
      resizeToAvoidBottomInset: true,
    );
    //!SECTION
  }

  @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
