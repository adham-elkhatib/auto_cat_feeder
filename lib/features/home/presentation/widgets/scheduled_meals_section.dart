import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/params/meal/meal_params.dart';
import '../../../cat_profile/domain/entities/cat_entity.dart';
import '../../../meals/domain/entities/meal_entity.dart';
import '../../../meals/presentation/widgets/delete_meal_alert_dialog.dart';
import '../../../meals/presentation/widgets/edit_serving_alert_dialog.dart';
import '../../../meals/presentation/widgets/schedule_card.dart';
import '../providers/home_bloc.dart';
import '../providers/home_event.dart';

class ScheduledMealsSection extends StatelessWidget {
  final CatEntity cat;
  final List<MealEntity> meals;

  const ScheduledMealsSection({
    super.key,
    required this.cat,
    required this.meals,
  });

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.event_busy_outlined,
                size: 44,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 8),
            Text(
              LocaleKeys.home_ui_empty_meals.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: List.generate(
        meals.length,
        (index) => ScheduleCard(
          meal: meals[index],
          onToggle: (value) {
            final toggledMeal =
                meals[index].copyWith(isEnabled: !meals[index].isEnabled);

            // context.read<HomeBloc>().add(
            //   ToggleMealEvent(
            //     mealId: toggledMeal.id,
            //     isEnabled: toggledMeal.isEnabled,
            //   ),
            // );
          },
          onDelete: () {
            _showDeleteMealDialog(context, meals[index]);
          },
          onEditServing: () async {
            final updatedMeal = await showDialog(
              context: context,
              builder: (context) => EditServingAlertDialog(
                meal: meals[index],
              ),
            );

            if (updatedMeal != null) {
              context.read<HomeBloc>().add(
                    UpdateMealServingEvent(
                      updatedMeal: updatedMeal,
                    ),
                  );
            }
          },
        ),
      ),
    );
  }

  Future<void> _showDeleteMealDialog(BuildContext context, MealEntity meal) {
    return showDialog<void>(
      context: context,
      builder: (context) => DeleteMealAlertDialog(
        meal: meal,
        onDelete: () {
          context.read<HomeBloc>().add(
                DeleteMealEvent(
                  params: DeleteMealParams(
                    id: meal.id,
                  ),
                ),
              );
          Navigator.pop(context);
        },
      ),
    );
  }
}
