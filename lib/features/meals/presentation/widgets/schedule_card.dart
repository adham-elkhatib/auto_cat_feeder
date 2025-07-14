import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../domain/entities/meal_entity.dart';

class ScheduleCard extends StatelessWidget {
  final MealEntity meal;
  final Function(bool) onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEditServing;

  const ScheduleCard({
    Key? key,
    required this.onToggle,
    required this.onDelete,
    required this.onEditServing,
    required this.meal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('hh:mm a').format(
                      DateTime(0, 1, 1, meal.time.hour, meal.time.minute)
                          .add(DateTime.now().timeZoneOffset)),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                // Switch(
                //   value: meal.isEnabled,
                //   onChanged: onToggle,
                //   activeColor: Colors.brown,
                // ),
              ],
            ),
            Text(
              LocaleKeys.meals_card_repeat_pattern
                  .tr(args: ['${meal.serving}']),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                  ),
                  icon: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/treat.svg",
                        height: 18,
                        width: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        LocaleKeys.meals_card_serving_label
                            .tr(args: ['${meal.serving}']),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                  onPressed: onEditServing,
                ),
                IconButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                  ),
                  icon: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        LocaleKeys.meals_card_delete.tr(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
