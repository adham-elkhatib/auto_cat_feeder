import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../cat_profile/domain/entities/cat_entity.dart';
import '../../../cat_profile/presentation/widgets/edit_pet_profile.dart';
import '../../../meals/domain/entities/meal_entity.dart';
import '../providers/home_bloc.dart';
import '../providers/home_event.dart';
import 'ai_insights_card.dart';
import 'feeder_management_card.dart';
import 'info_card.dart';
import 'scheduled_meals_section.dart';

class HomeBodyContent extends StatelessWidget {
  final CatEntity cat;
  final List<MealEntity> meals;

  const HomeBodyContent({
    super.key,
    required this.cat,
    required this.meals,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoCard(
            cat: cat,
            numberOfMeals: meals.length,
            onOpenSheet: () => _showEditPetProfileBottomSheet(context, cat),
          ),
          const SizedBox(height: 16),
          AIInsightsCard(cat: cat),
          const SizedBox(height: 16),
          const FeederManagementCard(),
          const SizedBox(height: 24),
          Text(
            LocaleKeys.home_ui_scheduled.tr(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ScheduledMealsSection(
            cat: cat,
            meals: meals,
          ),
        ],
      ),
    );
  }

  Future<void> _showEditPetProfileBottomSheet(
      BuildContext context, CatEntity cat) async {
    final updatedPet = await showModalBottomSheet<CatEntity>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => EditCatProfile(cat: cat),
    );

    if (updatedPet != null) {
      context
          .read<HomeBloc>()
          .add(UpdatePetProfileEvent(updatedCat: updatedPet));
    }
  }
}
