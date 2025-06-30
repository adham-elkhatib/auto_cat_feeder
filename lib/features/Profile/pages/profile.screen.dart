//t2 Core Packages Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Data/Model/App User/app_user.model.dart';
import '../../../../Data/Repositories/user.repo.dart';
import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Auth/src/Providers/auth_provider.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/section_title.dart';
import '../../authentication/presentation/pages/landing.screen.dart';

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
  UserModel? appUser;
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool isLoading = true;

  //t2 --Controllers
  //
  //t2 --State

  //t2 --State
  //
  //t2 --Constants
  final _formKey = GlobalKey<FormState>();

  //t2 --Constants
  //!SECTION

  @override
  void initState() {
    super.initState();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --Controllers & Listeners
    //t2 --Controllers & Listeners
    //
    //t2 --State
    String? userId = AuthService(
      authProvider: FirebaseAuthProvider(firebaseAuth: FirebaseAuth.instance),
    ).getCurrentUserId();
    if (userId != null) {
      UserRepo().readSingle(userId).then((value) {
        setState(() {
          appUser = value;
          _fNameController.text = "${appUser?.fName}";
          _lNameController.text = "${appUser?.lName}";
          _emailController.text = "${appUser?.email}";
          _phoneNumberController.text = "${appUser?.phoneNumber}";
          isLoading = false;
        });
      });
    }
    //t2 --State
    //
    //t2 --Late & Async Initializers
    //t2 --Late & Async Initializers
    //!SECTION
  }

  //SECTION - Stateless functions
  //!SECTION

  //SECTION - Action Callbacks
  //!SECTION
  @override
  Widget build(BuildContext context) {
    //SECTION - Build Setup
    //t2 -Values
    //double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"), // Already in English
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                AuthService(
                  authProvider: FirebaseAuthProvider(
                    firebaseAuth: FirebaseAuth.instance,
                  ),
                ).signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const LandingScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Text(
                'Sign Out',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ))
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SectionTitle(title: "Account Details"),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _fNameController,
                      decoration: const InputDecoration(
                        hintText: "First Name",
                        labelText: "First Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'The first name cannot be empty';
                        } else if (value.length < 3) {
                          return 'The first name must be at least 3 characters long';
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
                        hintText: "Last Name",
                        labelText: "Last Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'The last name cannot be empty';
                        } else if (value.length < 3) {
                          return 'The last name must be at least 3 characters long';
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
                      readOnly: true,
                      enabled: false,
                      decoration: const InputDecoration(
                        hintText: "Email Address",
                        labelText: "Email Address",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SectionTitle(title: "Personal Information"),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
                        hintText: "Phone Number",
                        labelText: "Phone Number",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (!RegExp(r'^05\d{8}$').hasMatch(value)) {
                          return 'The phone number must start with "05" and be 10 digits long';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 42),
        child: PrimaryButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              appUser?.fName = _fNameController.text;
              appUser?.email = _emailController.text;
              appUser?.phoneNumber = _phoneNumberController.text;

              await UserRepo().updateSingle(appUser!.id, appUser!);
              SnackbarHelper.showTemplated(
                context,
                title: "Your profile has been successfully updated!",
              );

              Navigator.pop(context);
            }
          },
          color: Theme.of(context).colorScheme.primary,
          title: 'Save',
        ),
      ),
    );
    //!SECTION
  }
}
