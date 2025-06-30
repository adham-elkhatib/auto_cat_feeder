import 'package:flutter/material.dart';

import '../../../../Data/Model/Cat/meal.model.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';

class EditServingAlertDialog extends StatelessWidget {
  final Meal meal;

  const EditServingAlertDialog({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController =
        TextEditingController(text: "${meal.serving}");
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: const Text('Edit serving amount'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
              'This will be the amount served by the feeder for the cat.'),
          const SizedBox(height: 16),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Serving amount (g)',
              border: UnderlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
          ),
        ),
        TextButton(
          onPressed: () {
            if (amountController.text.isNotEmpty) {
              final newServing = int.tryParse(amountController.text);
              if (newServing != null && newServing > 0) {
                meal.serving = newServing;
                Navigator.pop(context, meal);
              } else {
                SnackbarHelper.showError(context,
                    title: 'Please enter a valid serving amount.');
              }
            }
          },
          child: const Text(
            'Save',
          ),
        ),
      ],
    );
  }
}
