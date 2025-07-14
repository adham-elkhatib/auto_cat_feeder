import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../domain/entities/cat_breed.dart';
import '../../domain/entities/energy_level.dart';
import '../../domain/entities/gender.dart';
import 'gender_toggle.dart';

class CatProfileForm extends StatelessWidget {
  final TextEditingController catNameController;
  final TextEditingController catAgeController;
  final TextEditingController catWeightController;
  final GlobalKey<FormState> formKey;

  final Gender selectedGender;
  final CatBreed selectedBreed;
  final EnergyLevel selectedEnergy;

  final void Function(CatBreed) onBreedChanged;
  final void Function(EnergyLevel) onEnergyChanged;
  final void Function(Gender) onGenderSelected;

  const CatProfileForm({
    super.key,
    required this.catNameController,
    required this.catAgeController,
    required this.catWeightController,
    required this.formKey,
    required this.selectedGender,
    required this.selectedBreed,
    required this.selectedEnergy,
    required this.onBreedChanged,
    required this.onEnergyChanged,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              LocaleKeys.cat_profile_description.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: catNameController,
              decoration: InputDecoration(
                hintText: LocaleKeys.cat_profile_form_name_hint.tr(),
                labelText: LocaleKeys.cat_profile_form_name.tr(),
                fillColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return LocaleKeys.cat_profile_errors_empty_name.tr();
                }
                if (value.length < 2) {
                  return LocaleKeys.cat_profile_errors_short_name.tr();
                }
                return null;
              },
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: catAgeController,
              decoration: InputDecoration(
                hintText: LocaleKeys.cat_profile_form_age_hint.tr(),
                labelText: LocaleKeys.cat_profile_form_age.tr(),
                fillColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return LocaleKeys.cat_profile_errors_empty_age.tr();
                }
                final int? age = int.tryParse(value);
                if (age == null || age <= 0) {
                  return LocaleKeys.cat_profile_errors_invalid_age.tr();
                }
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: catWeightController,
              decoration: InputDecoration(
                hintText: LocaleKeys.cat_profile_form_weight_hint.tr(),
                labelText: LocaleKeys.cat_profile_form_weight.tr(),
                fillColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return LocaleKeys.cat_profile_errors_empty_weight.tr();
                }
                final double? weight = double.tryParse(value);
                if (weight == null || weight <= 0) {
                  return LocaleKeys.cat_profile_errors_invalid_weight.tr();
                }
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<CatBreed>(
              value: selectedBreed,
              decoration: InputDecoration(
                labelText: LocaleKeys.cat_profile_form_breed.tr(),
              ),
              items: CatBreed.values
                  .map((b) => DropdownMenuItem(
                        value: b,
                        child: Text(b.label),
                      ))
                  .toList(),
              onChanged: (value) => onBreedChanged(selectedBreed),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<EnergyLevel>(
              value: selectedEnergy,
              decoration: InputDecoration(
                labelText: LocaleKeys.cat_profile_form_energy.tr(),
              ),
              items: EnergyLevel.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.label),
                      ))
                  .toList(),
              onChanged: (value) => onEnergyChanged(selectedEnergy),
            ),
            const SizedBox(height: 16),
            GenderToggle(
              onGenderSelected: onGenderSelected,
            ),
          ],
        ),
      ),
    );
  }
}
