import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../providers/home_bloc.dart';
import '../providers/home_event.dart';
import '../widgets/home_body_content.dart';
import '../widgets/home_floating_action_buttons.dart';
import '../widgets/profile_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(LoadHomeDataEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home_ui_welcome.tr()),
        actions: const [
          ProfileIconButton(),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeError) {
            return Center(
              child: Text(
                state.message.tr(),
              ),
            );
          } else if (state is HomeLoaded) {
            return HomeBodyContent(
              cat: state.cat,
              meals: state.meals ?? [],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: const HomeFloatingActionButtons(),
    );
  }
}
