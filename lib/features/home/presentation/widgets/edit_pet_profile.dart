import 'package:flutter/material.dart';

import '../../../../Data/Model/Cat/cat.model.dart';
import '../../../../Data/Model/Cat/cat_breed.dart';
import '../../../../Data/Model/Cat/energy_level.dart';
import '../../../../Data/Model/Cat/gender.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../../Profile/widgets/gender_toggle.dart';

class EditPetProfile extends StatefulWidget {
  final Cat pet;

  const EditPetProfile({super.key, required this.pet});

  @override
  State<EditPetProfile> createState() => _EditPetProfileState();
}

class _EditPetProfileState extends State<EditPetProfile> {
  late TextEditingController catNameController = TextEditingController();
  late TextEditingController catAgeController = TextEditingController();
  late TextEditingController catWeightController = TextEditingController();
  late Gender selectedGender;
  late CatBreed selectedBreed;
  late EnergyLevel selectedEnergyLevel;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    catNameController.text = widget.pet.name;
    catAgeController.text = widget.pet.age.toString();
    catWeightController.text = widget.pet.weight.toString();
    selectedGender = widget.pet.gender;
    selectedBreed = widget.pet.breed;
    selectedEnergyLevel = widget.pet.energyLevel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: catNameController,
                    decoration: InputDecoration(
                      hintText: "Enter your cat’s name",
                      labelText: "Cat’s name",
                      fillColor:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your cat’s name.';
                      }
                      if (value.length < 2) {
                        return 'Name must be at least 2 characters long.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: catAgeController,
                    decoration: InputDecoration(
                      hintText: "Enter your cat’s age",
                      labelText: "Cat’s age",
                      fillColor:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your cat’s age.';
                      }
                      final int? age = int.tryParse(value);
                      if (age == null || age <= 0) {
                        return 'Please enter a valid age.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: catWeightController,
                    decoration: InputDecoration(
                      hintText: "Enter your cat’s weight",
                      labelText: "Cat’s weight",
                      fillColor:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your cat’s weight.';
                      }
                      final double? weight = double.tryParse(value);
                      if (weight == null || weight <= 0) {
                        return 'Please enter a valid weight.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<CatBreed>(
                    value: selectedBreed,
                    decoration: InputDecoration(
                      labelText: "Breed",
                      fillColor:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
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
                      labelText: "Energy Level",
                      fillColor:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
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
                  Text(
                    "Let’s get to know your cat to provide personalized care.",
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
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SecondaryButton(
                  title: "Cancel",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
                PrimaryButton(
                  title: 'Save',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final updatedPet = widget.pet.copyWith(
                        gender: selectedGender,
                        name: catNameController.text,
                        id: widget.pet.id,
                        age: int.parse(catAgeController.text),
                        weight: double.parse(catWeightController.text),
                        breed: selectedBreed,
                        energyLevel: selectedEnergyLevel,
                      );

                      SnackbarHelper.showTemplated(
                        context,
                        title: "Details updated successfully.",
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
    );
  }
}
