import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../Data/Model/Cat/cat.model.dart';
import '../../../../Data/Model/Cat/cat_breed.dart';
import '../../../../Data/Model/Cat/energy_level.dart';
import '../../../../Data/Model/Cat/gender.dart';
import '../../../../constants.dart';

class AIInsightsCard extends StatefulWidget {
  final Cat cat;

  const AIInsightsCard({
    Key? key,
    required this.cat,
  }) : super(key: key);

  @override
  State<AIInsightsCard> createState() => _AIInsightsCardState();
}

class _AIInsightsCardState extends State<AIInsightsCard> {
  String status = "Press update to get insights.";
  String recommendation = "";
  bool isLoading = false;

  Future<void> _fetchAIRecommendation() async {
    setState(() {
      isLoading = true;
    });

    try {
      final url = Uri.parse("$apiBaseUrl/predict/");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "breed": widget.cat.breed.label,
          "sex": widget.cat.gender.label,
          "age_years": widget.cat.age,
          "weight_kg": widget.cat.weight,
          "energy_level": widget.cat.energyLevel.label,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final grams = data['Predicted Daily Food Intake (g)'];

        setState(() {
          status = "${widget.cat.name} looks healthy!";
          recommendation =
              "Recommended daily intake: ${grams.toStringAsFixed(1)}g";
        });
      } else {
        setState(() {
          status = "Failed to get prediction.";
          recommendation = "Please try again later.";
        });
      }
    } catch (e) {
      setState(() {
        status = "Error: ${e.toString()}";
        recommendation = "";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
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
                      "AI insights",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    Text(
                      "Summary",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
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
                // todo البوكس ده بيبقا فاضي فى الأول و شكله مش حلو
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
                        : "No recommendation yet.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontStyle: recommendation.isNotEmpty
                              ? FontStyle.normal
                              : FontStyle.italic,
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: isLoading ? null : _fetchAIRecommendation,
                  icon: const Icon(Icons.refresh),
                  label: Text(isLoading ? "Updating..." : "Update"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
