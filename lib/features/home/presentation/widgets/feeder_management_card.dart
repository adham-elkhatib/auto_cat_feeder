import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../feeder/presentation/providers/feeder_bloc.dart';
import '../providers/home_bloc.dart';
import 'feeder_connection_bottom_sheet.dart';

class FeederManagementCard extends StatefulWidget {
  const FeederManagementCard({super.key});

  @override
  State<FeederManagementCard> createState() => _FeederManagementCardState();
}

class _FeederManagementCardState extends State<FeederManagementCard> {
  String? feederId;
  bool hasRequestedStatus = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final homeState = context.read<HomeBloc>().state;
    final feederBloc = context.read<FeederBloc>();
    final feederState = feederBloc.state;

    if (homeState is HomeLoaded) {
      feederId = homeState.cat.feederId;
    }

    final shouldTriggerStatus = feederId != null &&
        !hasRequestedStatus &&
        (feederState is! FeederStatusUpdated ||
            feederState.feeder.id != feederId);

    if (shouldTriggerStatus) {
      hasRequestedStatus = true;
      feederBloc.add(StreamFeederStatusEvent(feederId: feederId!));
    }
  }

  void _showFeederBottomSheet() {
    showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const FeederConnectionBottomSheet(),
    ).then((_) {
      final homeState = context.read<HomeBloc>().state;
      if (homeState is HomeLoaded && homeState.cat.feederId != null) {
        context.read<FeederBloc>().add(
              StreamFeederStatusEvent(feederId: homeState.cat.feederId!),
            );
      }
    });
  }

  Widget _infoText({
    IconData? icon,
    String? customIcon,
    required String label,
  }) {
    return Row(
      children: [
        if (customIcon != null)
          SvgPicture.asset(
            customIcon,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        if (icon != null)
          Icon(
            icon,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeederBloc, FeederState>(
      builder: (context, state) {
        late final Widget statusText;
        late final Widget statusDetails;

        if (state is FeederConnecting) {
          statusText = Text(LocaleKeys.home_feeder_connecting.tr());
          statusDetails = const CircularProgressIndicator();
        } else if (state is FeederStatusUpdated) {
          final feeder = state.feeder;
          statusText = Text(
            LocaleKeys.home_feeder_connected.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          );
          statusDetails = Row(
            children: [
              _infoText(
                icon: Icons.wifi,
                label: LocaleKeys.home_feeder_status_connected.tr(),
              ),
              const SizedBox(width: 24),
              feeder.foodContainerEmpty == false
                  ? _infoText(
                      customIcon: "assets/icons/full_container.svg",
                      label: LocaleKeys.home_feeder_status_full.tr(),
                    )
                  : _infoText(
                      customIcon: "assets/icons/empty_container.svg",
                      label: LocaleKeys.home_feeder_status_empty.tr(),
                    ),
            ],
          );
        } else if (state is FeederError) {
          statusText = Text(
            "Error: ${state.message}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          );
          statusDetails = _infoText(
            icon: Icons.wifi_off,
            label: LocaleKeys.home_feeder_connection_failed.tr(),
          );
        } else {
          statusText = Text(LocaleKeys.home_feeder_not_connected.tr());
          statusDetails = _infoText(
            icon: Icons.wifi_off,
            label: LocaleKeys.home_feeder_not_connected.tr(),
          );
        }

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.settings_remote,
                        size: 24,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.home_feeder_title.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        statusText,
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: _showFeederBottomSheet,
                      icon: const Icon(Icons.more_vert),
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: statusDetails,
              ),
            ],
          ),
        );
      },
    );
  }
}
