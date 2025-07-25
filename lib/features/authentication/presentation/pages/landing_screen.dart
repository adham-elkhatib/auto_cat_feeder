//t2 Core Packages Imports
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class LandingScreen extends StatelessWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const LandingScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    //SECTION - Build Setup
    //t2 -Values
    //t2 -Values
    //
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/app_logo.png',
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                title: LocaleKeys.auth_landing_sign_in.tr(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const SignInScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: SecondaryButton(
                title: LocaleKeys.auth_landing_sign_up.tr(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const SignUpScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 26),
          ],
        ),
      ),
    );

    //!SECTION
  }
}
