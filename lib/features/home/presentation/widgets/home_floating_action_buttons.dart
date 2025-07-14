import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/params/meal/meal_params.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../feeder/presentation/pages/live_camera_feed.dart';
import '../../../feeder/presentation/providers/feeder_bloc.dart';
import '../providers/home_bloc.dart';
import '../providers/home_event.dart';

class HomeFloatingActionButtons extends StatelessWidget {
  const HomeFloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BlocBuilder<FeederBloc, FeederState>(
          builder: (context, feederState) {
            final bool isConnected = feederState is FeederStatusUpdated;
            final feeder = isConnected ? feederState.feeder : null;

            return GestureDetector(
              onTap: () {
                if (feeder?.ipAddress == null) {
                  SnackbarHelper.showError(context,
                      title: LocaleKeys.home_feeder_actions_connect_first.tr());
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => LiveCameraFeed(ip: feeder!.ipAddress!),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 24,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () async {
            TimeOfDay? time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (time != null) {
              final now = DateTime.now();
              final selectedDateTime = DateTime(
                now.year,
                now.month,
                now.day,
                time.hour,
                time.minute,
              );
              final adjustedDateTime =
                  selectedDateTime.subtract(now.timeZoneOffset);
              final adjustedTime = TimeOfDay(
                hour: adjustedDateTime.hour,
                minute: adjustedDateTime.minute,
              );
              final MealParams params = MealParams(
                serving: 0,
                time: adjustedTime,
                isEnabled: true,
              );

              context.read<HomeBloc>().add(AddMealEvent(newMeal: params));
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(22),
            child: Icon(
              Icons.add,
              size: 36,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}
