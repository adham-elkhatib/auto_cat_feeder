import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Data/Model/Cat/feeder_model.dart';
import '../../../../Data/Repositories/feeder_repo.dart';

class FeederManagementCard extends StatefulWidget {
  final FeederModel feeder;
  final bool isConnected;
  final bool hasFood;
  final VoidCallback onOpenSheet;

  const FeederManagementCard({
    Key? key,
    required this.isConnected,
    required this.hasFood,
    required this.onOpenSheet,
    required this.feeder,
  }) : super(key: key);

  @override
  State<FeederManagementCard> createState() => _FeederManagementCardState();
}

class _FeederManagementCardState extends State<FeederManagementCard> {
  FeederModel? currentFeeder;
  String? deviceId;

  @override
  void initState() {
    currentFeeder = widget.feeder;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget infoText(
        {IconData? icon, String? customIcon, required String label}) {
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

    return StreamBuilder(
      stream:
          FeederRepo().onUpdate().where((data) => data?.id == "32971015350"),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          currentFeeder = snapshot.data;
        }
        return Card(
          elevation: 0,
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
                          "Feeder Management",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        Text(
                          "Overall status",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        )
                      ],
                    ),
                    // const Spacer(),
                    // IconButton(
                    //   onPressed: () => onOpenSheet(),
                    //   icon: const Icon(Icons.more_vert),
                    //   color: Theme.of(context).colorScheme.onSurfaceVariant,
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    infoText(
                      icon: Icons.wifi,
                      label: "Connected",
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    (currentFeeder?.foodContainerEmpty == false)
                        ? infoText(
                            customIcon: "assets/icons/full_container.svg",
                            label: "Contains food",
                          )
                        : infoText(
                            customIcon: "assets/icons/empty_container.svg",
                            label: "Container empty",
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
