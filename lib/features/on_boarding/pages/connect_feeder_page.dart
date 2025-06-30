import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Data/Model/Cat/cat.model.dart';
import '../../../Data/Repositories/cat_repo.dart';
import '../../../core/Services/Auth/auth.service.dart';
import '../../../core/Services/Auth/src/Providers/auth_provider.dart';
import '../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../core/widgets/primary_button.dart';
import '../../home/presentation/pages/home.screen.dart';

class ConnectFeederPage extends StatefulWidget {
  final Cat cat;

  const ConnectFeederPage({super.key, required this.cat});

  @override
  State<ConnectFeederPage> createState() => _ConnectFeederPageState();
}

class _ConnectFeederPageState extends State<ConnectFeederPage> {
  late Cat localCat;
  bool isLoading = true;

  @override
  void initState() {
    setState(() {
      localCat = widget.cat;
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> saveCat(Cat cat) async {
      try {
        String? userId = AuthService(
          authProvider: FirebaseAuthProvider(
            firebaseAuth: FirebaseAuth.instance,
          ),
        ).getCurrentUserId();
        cat = cat.copyWith(userId: userId, id: userId);
        await CatRepo().createSingle(cat, itemId: userId);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_first_time', false);

        print('Cat data saved: ${cat.toJson()}');
      } catch (e) {
        print('Failed to save cat data: $e');
      }
    }

    Future<void> saveCachedBarcode(String cachedDeviceId) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cached_feeder_id', cachedDeviceId);
    }

    Future<String?> openQRCodeReader() async {
      try {
        var result = await BarcodeScanner.scan();

        if (result.type == ResultType.Barcode) {
          await saveCachedBarcode(result.rawContent);
          localCat = widget.cat.copyWith(
            feederId: result.rawContent,
          );
          await saveCat(widget.cat);
          SnackbarHelper.showTemplated(
            context,
            title: 'Feeder connected successfully.',
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomeScreen(),
            ),
            (route) => false,
          );
          return result.rawContent;
        } else {
          SnackbarHelper.showError(context, title: "No barcode scanned.");
        }
      } catch (e) {
        print("Error Occurred!: $e");
        SnackbarHelper.showError(context, title: "Failed to scan the barcode.");
      }
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect your feeder"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                children: [
                  Text(
                    "Scan the barcode on your feeder to link it with the app.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SvgPicture.asset(
                    'assets/images/barcode.svg',
                    width: 350,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      child: Text(
                        "Make sure your feeder is powered on and ready to scan.",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            title: 'Scan now',
            icon: Icons.camera_alt_outlined,
            onPressed: () async {
              await openQRCodeReader();
            },
          ),
        ),
      ),
    );
  }
}
