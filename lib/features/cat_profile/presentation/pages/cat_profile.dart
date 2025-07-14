import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../../locator.dart';
import '../../domain/entities/cat_breed.dart';
import '../../domain/entities/energy_level.dart';
import '../../domain/entities/gender.dart';
import '../providers/cat_profile_bloc.dart';
import '../widgets/cat_profile_bottom_nav.dart';
import '../widgets/cat_profile_form.dart';

class CatProfile extends StatefulWidget {
  const CatProfile({super.key});

  @override
  State<CatProfile> createState() => _CatProfileState();
}

class _CatProfileState extends State<CatProfile> {
  final TextEditingController catNameController = TextEditingController();
  final TextEditingController catAgeController = TextEditingController();
  final TextEditingController catWeightController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  Gender selectedGender = Gender.male;
  CatBreed selectedBreed = CatBreed.abyssinian;
  EnergyLevel selectedEnergy = EnergyLevel.moderate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<CatProfileBloc>(),
        child: BlocConsumer<CatProfileBloc, CatProfileState>(
          listener: (context, state) {
            if (state is CatProfileSuccess) {
              if (state.message != null) {
                SnackbarHelper.showSuccess(
                  context,
                  title: state.message!,
                );
                // todo implement later
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => ConnectFeederPage(
                //       cat: state.cat,
                //     ),
                //   ),
                // );
              }
            }
            if (state is CatProfileFailure) {
              SnackbarHelper.showError(context, title: state.message);
            }
          },
          builder: (context, state) {
            if (state is CatProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Scaffold(
              appBar: AppBar(
                title: Text(LocaleKeys.cat_profile_title.tr()),
                centerTitle: true,
              ),
              body: CatProfileForm(
                formKey: formKey,
                catAgeController: catAgeController,
                catNameController: catNameController,
                catWeightController: catWeightController,
                selectedBreed: selectedBreed,
                selectedEnergy: selectedEnergy,
                selectedGender: selectedGender,
                onBreedChanged: (value) =>
                    setState(() => selectedBreed = value),
                onEnergyChanged: (value) =>
                    setState(() => selectedEnergy = value),
                onGenderSelected: (value) =>
                    setState(() => selectedGender = value),
              ),
              bottomNavigationBar: CatProfileBottomNav(
                formKey: formKey,
                catAgeController: catAgeController,
                catNameController: catNameController,
                catWeightController: catWeightController,
                selectedBreed: selectedBreed,
                selectedEnergy: selectedEnergy,
                selectedGender: selectedGender,
              ),
            );
          },
        ));
  }

  @override
  void dispose() {
    catNameController.dispose();
    catAgeController.dispose();
    catWeightController.dispose();
    super.dispose();
  }
}
