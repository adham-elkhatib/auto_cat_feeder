import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../cat_profile/domain/entities/cat_entity.dart';
import '../providers/home_bloc.dart';
import '../providers/home_event.dart';

class FeederConnectionBottomSheet extends StatelessWidget {
  const FeederConnectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeBloc>().state;
    final CatEntity? cat = homeState is HomeLoaded ? homeState.cat : null;
    final String? feederId = cat?.feederId;

    Future<void> connectFeeder(String scannedId) async {
      if (cat == null) return;

      context.read<HomeBloc>().add(
            ConnectFeederEvent(
              feederId: scannedId,
              cat: cat,
            ),
          );
    }

    Future<void> disconnectFeeder() async {
      if (feederId == null) return;

      context.read<HomeBloc>().add(
            DisconnectFeederEvent(
              feederId: feederId,
            ),
          );
    }

    Future<void> openQRCodeReader() async {
      try {
        final result = await BarcodeScanner.scan();
        if (result.type == ResultType.Barcode) {
          await connectFeeder(result.rawContent);
        } else {
          SnackbarHelper.showError(
            context,
            title: LocaleKeys.home_feeder_actions_no_barcode.tr(),
          );
        }
      } catch (e) {
        SnackbarHelper.showError(
          context,
          title: LocaleKeys.home_feeder_actions_scan_failed.tr(),
        );
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (feederId == null)
          ListTile(
            leading: const Icon(Icons.camera_enhance_outlined),
            title: Text(
              LocaleKeys.home_feeder_actions_scan.tr(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            onTap: () async {
              await openQRCodeReader();
              Navigator.pop(context);
            },
          ),
        Divider(color: Theme.of(context).colorScheme.outlineVariant),
        if (feederId != null)
          ListTile(
            leading: const Icon(Icons.wifi_off_outlined),
            title: Text(
              LocaleKeys.home_feeder_actions_disconnect.tr(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            onTap: () async {
              await disconnectFeeder();
              Navigator.pop(context);
            },
          ),
        const SizedBox(height: 24),
      ],
    );
  }
}
