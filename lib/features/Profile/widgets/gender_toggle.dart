import 'package:flutter/material.dart';

import '../../../Data/Model/Cat/gender.dart';

class GenderToggle extends StatefulWidget {
  final ValueChanged<Gender> onGenderSelected;

  const GenderToggle({super.key, required this.onGenderSelected});

  @override
  State<GenderToggle> createState() => _GenderToggleState();
}

class _GenderToggleState extends State<GenderToggle> {
  Gender selectedGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SegmentedButton<Gender>(
            segments: [
              ButtonSegment(
                value: Gender.male,
                label: Text(Gender.male.name),
              ),
              ButtonSegment(
                value: Gender.female,
                label: Text(Gender.female.name),
              ),
            ],
            selected: <Gender>{selectedGender},
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Theme.of(context).colorScheme.secondaryContainer;
                  }
                  return Theme.of(context).colorScheme.surface;
                },
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Theme.of(context).colorScheme.onSecondaryContainer;
                  }
                  return Theme.of(context).colorScheme.onSurface;
                },
              ),
              minimumSize: WidgetStateProperty.all(
                const Size(double.infinity, 48),
              ),
            ),
            onSelectionChanged: (Set<Gender> newSelection) {
              setState(() {
                selectedGender = newSelection.first;
                widget.onGenderSelected(selectedGender);
              });
            },
          ),
        ),
      ],
    );
  }
}
