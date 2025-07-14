import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/widgets/primary_button.dart';

// NOT USED
class ScanButton extends StatelessWidget {
  final VoidCallback onScan;

  const ScanButton({super.key, required this.onScan});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: PrimaryButton(
          title: LocaleKeys.feeder_instructions_scan_button.tr(),
          icon: Icons.camera_alt_outlined,
          onPressed: onScan,
        ),
      ),
    );
  }
}
