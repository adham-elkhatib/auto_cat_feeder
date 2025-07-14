import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../cat_profile/domain/entities/cat_breed.dart';
import '../../../cat_profile/domain/entities/cat_entity.dart';
import '../../../cat_profile/domain/entities/energy_level.dart';

class InfoCard extends StatelessWidget {
  final CatEntity cat;
  final VoidCallback onOpenSheet;
  final int numberOfMeals;

  const InfoCard({
    Key? key,
    required this.cat,
    required this.onOpenSheet,
    required this.numberOfMeals,
  }) : super(key: key);

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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.pets,
                    size: 24,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cat.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    Text(
                      LocaleKeys.home_info_card_status.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => onOpenSheet(),
                  icon: const Icon(Icons.edit),
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                infoText(
                  customIcon: "assets/icons/weight.svg",
                  label: LocaleKeys.home_info_card_weight.tr(
                    namedArgs: {'': cat.weight.toString()},
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                infoText(
                  customIcon: "assets/icons/treat.svg",
                  label: LocaleKeys.home_info_card_meals
                      .tr(namedArgs: {'': numberOfMeals.toString()}),
                ),
                const SizedBox(
                  width: 8,
                ),
                infoText(
                  icon: Icons.calendar_today,
                  label: LocaleKeys.home_info_card_age
                      .tr(namedArgs: {'': cat.age.toString()}),
                ),
                const SizedBox(
                  width: 8,
                ),
                infoText(
                  icon: Icons.category,
                  label: cat.breed.label,
                ),
                const SizedBox(
                  width: 8,
                ),
                infoText(
                  icon: Icons.bolt,
                  label: cat.energyLevel.label,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
