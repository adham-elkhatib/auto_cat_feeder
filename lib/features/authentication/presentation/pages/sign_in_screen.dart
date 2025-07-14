// ✅ Core Imports
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../widgets/sign_in_bottom_nav.dart';
import '../widgets/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  late FormController formController;

  @override
  void initState() {
    formController = FormController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.auth_sign_in_title.tr()),
      ),
      body: SignInForm(formController: formController, formKey: formKey),
      bottomNavigationBar:
          SignInBottomNav(formController: formController, formKey: formKey),
    );
  }

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }
}
