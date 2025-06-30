//t2 Core Packages Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Data/Model/App User/app_user.model.dart';
import '../../../../Data/Repositories/user.repo.dart';
import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Auth/models/auth.model.dart';
import '../../../../core/Services/Auth/src/Providers/auth_provider.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/tertiary_button.dart';
import '../../../on_boarding/pages/on_boarding_page.dart';
import 'sign_in.screen.dart';

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
  //
  //SECTION - State Variables
  //t2 --Controllers
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool hasMinLength = false;
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  //t2 --Controllers
  //
  //t2 --State
  //t2 --State
  //
  //t2 --Constants
  final _formKey = GlobalKey<FormState>();

  //t2 --Constants
  //!SECTION
  //SECTION - Stateless functions
  //!SECTION

  //SECTION - Action Callbacks
  //!SECTION

  @override
  Widget build(BuildContext context) {
    //SECTION - Build Setup
    //t2 -Values
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Account', // Already in English
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account Information', // Already in English
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _fNameController,
                    decoration: const InputDecoration(
                      hintText: "First name", // Already in English
                      labelText: "First name", // Already in English
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'The first name cannot be empty'; // Translated from 'لا يمكن أن يكون الاسم الأول فارغًا'
                      } else if (value.length < 3) {
                        return 'The first name must be at least 3 characters long'; // Translated from 'الاسم الأول يجب أن يتكون من 3 أحرف على الأقل'
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _lNameController,
                    decoration: const InputDecoration(
                      hintText: "Last name", // Already in English
                      labelText: "Last Name", // Already in English
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'The last name cannot be empty'; // Translated from 'لا يمكن أن يكون الاسم الأخير فارغًا'
                      } else if (value.length < 3) {
                        return 'The last name must be at least 3 characters long'; // Translated from 'الاسم الأخير يجب أن يتكون من 3 أحرف على الأقل'
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "exa@example.com", // Already in English
                      labelText: "Email", // Already in English
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email'; // Translated from 'الرجاء إدخال بريدك الإلكتروني'
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address'; // Translated from 'يرجى إدخال عنوان بريد إلكتروني صالح'
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Password", // Already in English
                              labelText: "Password", // Already in English
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              setState(() {
                                hasMinLength = value.length >= 8;
                                hasUpperCase = RegExp(r'[A-Z]').hasMatch(value);
                                hasLowerCase = RegExp(r'[a-z]').hasMatch(value);
                                hasNumber = RegExp(r'[0-9]').hasMatch(value);
                                hasSpecialChar =
                                    RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                        .hasMatch(value);
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'The password cannot be empty'; // Translated from 'لا يمكن أن تكون كلمة المرور فارغة'
                              } else if (!hasMinLength) {
                                return 'The password must be at least 8 characters long'; // Translated from 'يجب أن تكون كلمة المرور مكونة من 8 أحرف على الأقل'
                              } else if (!hasUpperCase) {
                                return 'The password must contain at least one uppercase letter'; // Translated from 'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل'
                              } else if (!hasLowerCase) {
                                return 'The password must contain at least one lowercase letter'; // Translated from 'يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل'
                              } else if (!hasNumber) {
                                return 'The password must contain at least one number'; // Translated from 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل'
                              } else if (!hasSpecialChar) {
                                return 'The password must contain at least one special character'; // Translated from 'يجب أن تحتوي كلمة المرور على رمز خاص واحد على الأقل'
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    hasMinLength ? Icons.check : Icons.close,
                                    color: hasMinLength
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text("At least 8 characters long"),
                                  // Translated from 'مكونة من 8 أحرف على الأقل'
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    hasUpperCase ? Icons.check : Icons.close,
                                    color: hasUpperCase
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                      "Contains at least one uppercase letter"),
                                  // Translated from 'تحتوي على حرف كبير واحد على الأقل'
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    hasLowerCase ? Icons.check : Icons.close,
                                    color: hasLowerCase
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                      "Contains at least one lowercase letter"),
                                  // Translated from 'تحتوي على حرف صغير واحد على الأقل'
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    hasNumber ? Icons.check : Icons.close,
                                    color:
                                        hasNumber ? Colors.green : Colors.red,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text("Contains at least one number"),
                                  // Translated from 'تحتوي على رقم واحد على الأقل'
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    hasSpecialChar ? Icons.check : Icons.close,
                                    color: hasSpecialChar
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                      "Contains at least one special character"),
                                  // Translated from 'تحتوي على رمز خاص واحد على الأقل'
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'General Information', // Translated from 'معلومات عامة'
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      hintText: "05********", // Already in English
                      labelText: "mobile number", // Already in English
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number'; // Translated from 'الرجاء إدخال رقم هاتفك'
                      }
                      if (!RegExp(r'^05\d{8}$').hasMatch(value)) {
                        return 'The phone number must start with "05" and be 10 digits long'; // Translated from 'يجب أن يبدأ رقم الهاتف بـ "05" ويتكون من 10 أرقام'
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    AuthService authService = AuthService(
                      authProvider: FirebaseAuthProvider(
                        firebaseAuth: FirebaseAuth.instance,
                      ),
                    );

                    AuthModel? authModel = await authService.signUp(
                      _emailController.text.trim(),
                      _passwordController.text,
                    );

                    if (authModel != null) {
                      UserModel user = UserModel(
                        id: authModel.uid,
                        email: _emailController.text,
                        fName: _fNameController.text,
                        lName: _lNameController.text,
                        phoneNumber: _phoneNumberController.text,
                      );

                      await UserRepo()
                          .createSingle(user, itemId: authModel.uid);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const OnBoardingPage(),
                        ),
                        (route) => false,
                      );
                    } else {
                      SnackbarHelper.showError(context,
                          title: 'Failed to sign up');
                    }
                  }
                },
                title: "Sign up",
              ),
            ),
            TertiaryButton(
              title: "I already have an account",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const SignInScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    //!SECTION
    super.dispose();
  }
}
