import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../domain/entities/cat_breed.dart';
import '../../domain/entities/cat_entity.dart';
import '../../domain/entities/energy_level.dart';
import '../../domain/entities/gender.dart';
import 'gender_toggle.dart';

class EditCatProfile extends StatefulWidget {
  final CatEntity cat;

  const EditCatProfile({super.key, required this.cat});

  @override
  State<EditCatProfile> createState() => _EditCatProfileState();
}

class _EditCatProfileState extends State<EditCatProfile> {
  late TextEditingController catNameController = TextEditingController();
  late TextEditingController catAgeController = TextEditingController();
  late TextEditingController catWeightController = TextEditingController();
  late Gender selectedGender;
  late CatBreed selectedBreed;
  late EnergyLevel selectedEnergyLevel;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    catNameController.text = widget.cat.name;
    catAgeController.text = widget.cat.age.toString();
    catWeightController.text = widget.cat.weight.toString();
    selectedGender = widget.cat.gender;
    selectedBreed = widget.cat.breed;
    selectedEnergyLevel = widget.cat.energyLevel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: catNameController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.cat_profile_form_name_hint.tr(),
                        labelText: LocaleKeys.cat_profile_form_name.tr(),
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
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
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
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
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.cat_profile_errors_empty_weight
                              .tr();
                        }
                        final double? weight = double.tryParse(value);
                        if (weight == null || weight <= 0) {
                          return LocaleKeys.cat_profile_errors_invalid_weight
                              .tr();
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
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        filled: true,
                      ),
                      items: CatBreed.values
                          .map((breed) => DropdownMenuItem(
                                value: breed,
                                child: Text(breed.label),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedBreed = value);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<EnergyLevel>(
                      value: selectedEnergyLevel,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.cat_profile_form_energy.tr(),
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        filled: true,
                      ),
                      items: EnergyLevel.values
                          .map((level) => DropdownMenuItem(
                                value: level,
                                child: Text(level.label),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedEnergyLevel = value);
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      LocaleKeys.cat_profile_description.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    const SizedBox(height: 8),
                    GenderToggle(
                      onGenderSelected: (Gender gender) {
                        setState(() {
                          selectedGender = gender;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SecondaryButton(
                    title: LocaleKeys.cat_profile_actions_cancel.tr(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 16),
                  PrimaryButton(
                    title: LocaleKeys.cat_profile_actions_save.tr(),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final updatedPet = widget.cat.copyWith(
                          gender: selectedGender,
                          name: catNameController.text,
                          id: widget.cat.id,
                          age: int.parse(catAgeController.text),
                          weight: double.parse(catWeightController.text),
                          breed: selectedBreed,
                          energyLevel: selectedEnergyLevel,
                        );

                        SnackbarHelper.showTemplated(
                          context,
                          title: LocaleKeys.cat_profile_success.tr(),
                        );

                        Navigator.pop(context, updatedPet);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
