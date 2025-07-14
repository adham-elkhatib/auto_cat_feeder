import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Services/Model Service/model_service.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../cat_profile/domain/entities/cat_breed.dart';
import '../../../cat_profile/domain/entities/cat_entity.dart';
import '../../../cat_profile/domain/entities/energy_level.dart';
import '../../../cat_profile/domain/entities/gender.dart';
import '../providers/home_bloc.dart';

class AIInsightsCard extends StatefulWidget {
  final CatEntity cat;

  const AIInsightsCard({
    Key? key,
    required this.cat,
  }) : super(key: key);

  @override
  State<AIInsightsCard> createState() => _AIInsightsCardState();
}

class _AIInsightsCardState extends State<AIInsightsCard> {
  String status = LocaleKeys.home_ai_default_status.tr();
  String recommendation = "";
  bool isLoading = false;

  CatEntity? lastCat;

  @override
  void initState() {
    super.initState();
    _fetchAIRecommendation();
    lastCat = widget.cat;
  }

  Future<void> _fetchAIRecommendation() async {
    setState(() {
      isLoading = true;
    });

    try {
      final grams = await ModelService().predict({
        "Breed": widget.cat.breed.label,
        "Sex": widget.cat.gender.label,
        "Age (Years)": widget.cat.age,
        "Weight (kg)": widget.cat.weight,
        "Energy Level": widget.cat.energyLevel.label,
      });

      setState(() {
        status = "${widget.cat.name} looks healthy!";
        recommendation = LocaleKeys.home_ai_recommendation
            .tr(args: [grams.toStringAsFixed(1)]);
      });
    } catch (e) {
      setState(() {
        status = "Error: ${e.toString()}";
        recommendation = LocaleKeys.home_ai_try_later.tr();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didUpdateWidget(covariant AIInsightsCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cat != oldWidget.cat) {
      _fetchAIRecommendation();
      lastCat = widget.cat;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (prev, curr) => curr is HomeLoaded && curr.cat != lastCat,
      listener: (context, state) {
        if (state is HomeLoaded) {
          setState(() {
            lastCat = state.cat;
          });
          _fetchAIRecommendation();
        }
      },
      child: Card(
        elevation: 0,
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
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.insights,
                      size: 23,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.home_ai_title.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      Text(
                        LocaleKeys.home_ai_summary.tr(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      recommendation.isNotEmpty
                          ? recommendation
                          : LocaleKeys.home_ai_no_recommendation.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontStyle: recommendation.isNotEmpty
                                ? FontStyle.normal
                                : FontStyle.italic,
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                    ),
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
