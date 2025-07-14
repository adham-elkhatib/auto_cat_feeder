import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/params/Cat/cat_params.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/cat_breed.dart';
import '../../domain/entities/energy_level.dart';
import '../../domain/entities/gender.dart';
import '../providers/cat_profile_bloc.dart';

class CatProfileBottomNav extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController catNameController;
  final TextEditingController catAgeController;
  final TextEditingController catWeightController;

  final Gender selectedGender;
  final CatBreed selectedBreed;
  final EnergyLevel selectedEnergy;

  const CatProfileBottomNav(
      {super.key,
      required this.formKey,
      required this.catNameController,
      required this.catAgeController,
      required this.catWeightController,
      required this.selectedGender,
      required this.selectedBreed,
      required this.selectedEnergy});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: PrimaryButton(
          title: LocaleKeys.cat_profile_actions_next.tr(),
          onPressed: context.watch<CatProfileBloc>().state is CatProfileLoading
              ? null
              : () async {
                  if (formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();

                    final age = int.tryParse(catAgeController.text) ?? 0;
                    final weight =
                        double.tryParse(catWeightController.text) ?? 0.0;

                    final bloc = context.read<CatProfileBloc>();
                    bloc.add(
                      SubmitProfileEvent(
                        params: CreateCatProfileParams(
                          name: catNameController.text.trim(),
                          age: age,
                          gender: selectedGender,
                          weight: weight,
                          breed: selectedBreed,
                          energyLevel: selectedEnergy,
                        ),
                      ),
                    );
                  }
                },
        ),
      ),
    );
  }
}
