import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/SnackBar/snackbar.helper.dart';

class FeederConnectionPage extends StatefulWidget {
  const FeederConnectionPage({
    super.key,
  });

  @override
  State<FeederConnectionPage> createState() => _FeederConnectionPageState();
}

class _FeederConnectionPageState extends State<FeederConnectionPage> {
  Future<void> _saveCachedBarcode(String cachedDeviceId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cached_feeder_id', cachedDeviceId);
  }

  Future<void> _deleteCachedBarcode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cached_feeder_id');
    SnackbarHelper.showTemplated(
      context,
      title: 'Feeder disconnected successfully.',
    );
  }

  Future<String?> openQRCodeReader() async {
    try {
      var result = await BarcodeScanner.scan();

      if (result.type == ResultType.Barcode) {
        await _saveCachedBarcode(result.rawContent);
        SnackbarHelper.showTemplated(
          context,
          title: 'Feeder connected successfully.',
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(
            Icons.camera_enhance_outlined,
          ),
          title: Text(
            "Scan to connect",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          onTap: () async {
            await openQRCodeReader();
            Navigator.pop(context);
          },
        ),
        Divider(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        ListTile(
          leading: const Icon(
            Icons.wifi_off_outlined,
          ),
          title: Text(
            "Disconnect feeder",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          onTap: () async {
            await _deleteCachedBarcode();
            Navigator.pop(context);
          },
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
