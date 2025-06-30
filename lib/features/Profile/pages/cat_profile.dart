import 'package:flutter/material.dart';

import '../../../Data/Model/Cat/cat.model.dart';
import '../../../Data/Model/Cat/cat_breed.dart';
import '../../../Data/Model/Cat/energy_level.dart';
import '../../../Data/Model/Cat/gender.dart';
import '../../../core/Services/Id Generating/id_generating.service.dart';
import '../../../core/widgets/primary_button.dart';
import '../../on_boarding/pages/connect_feeder_page.dart';
import '../widgets/gender_toggle.dart';

class CatProfile extends StatefulWidget {
  const CatProfile({super.key});

  @override
  State<CatProfile> createState() => _CatProfileState();
}

class _CatProfileState extends State<CatProfile> {
  final TextEditingController catNameController = TextEditingController();
  final TextEditingController catAgeController = TextEditingController();
  final TextEditingController catWeightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Gender selectedGender = Gender.male;
  CatBreed selectedBreed = CatBreed.abyssinian;
  EnergyLevel selectedEnergy = EnergyLevel.moderate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Your Cat's Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Let’s get to know your cat to provide personalized care.",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 16),
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
                decoration: const InputDecoration(
                  labelText: 'Breed',
                ),
                items: CatBreed.values
                    .map((b) => DropdownMenuItem(
                          value: b,
                          child: Text(b.label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBreed = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<EnergyLevel>(
                value: selectedEnergy,
                decoration: const InputDecoration(
                  labelText: 'Energy Level',
                ),
                items: EnergyLevel.values
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedEnergy = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            title: 'Next',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String catId = IdGeneratingService.generate();
                Cat cat = Cat(
                  id: catId,
                  name: catNameController.text,
                  age: int.parse(catAgeController.text),
                  gender: selectedGender,
                  weight: double.parse(catWeightController.text),
                  userId: "",
                  breed: selectedBreed,
                  energyLevel: selectedEnergy,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ConnectFeederPage(
                      cat: cat,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
