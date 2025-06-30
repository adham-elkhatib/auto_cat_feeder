import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Data/Model/Cat/cat.model.dart';
import '../../../../Data/Model/Cat/cat_breed.dart';
import '../../../../Data/Model/Cat/energy_level.dart';

class InfoCard extends StatelessWidget {
  final Cat cat;
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
                      "Overall status",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    )
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
                    label: "${cat.weight} KG"),
                const SizedBox(
                  width: 8,
                ),
                infoText(
                  customIcon: "assets/icons/treat.svg",
                  label: "$numberOfMeals Meals",
                ),
                const SizedBox(
                  width: 8,
                ),
                infoText(
                  icon: Icons.calendar_today,
                  label: "${cat.age} Years old",
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
