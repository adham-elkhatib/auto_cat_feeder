import 'package:flutter/material.dart';

import '../../../../Data/Model/Cat/meal.model.dart';

class DeleteMealAlertDialog extends StatelessWidget {
  final Meal meal;
  final VoidCallback onDelete;

  const DeleteMealAlertDialog(
      {super.key, required this.meal, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text(
        'Delete meal',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      content: Text(
        'Are you sure you want to delete the scheduled meal?',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
          ),
        ),
        TextButton(
          onPressed: onDelete,
          child: const Text('Delete', style: TextStyle(color: Colors.brown)),
        ),
      ],
    );
  }
}
