import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../domain/entities/meal_entity.dart';

class DeleteMealAlertDialog extends StatelessWidget {
  final MealEntity meal;
  final VoidCallback onDelete;

  const DeleteMealAlertDialog({
    super.key,
    required this.meal,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text(
        LocaleKeys.meals_dialogs_delete_title.tr(),
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      content: Text(
        LocaleKeys.meals_dialogs_delete_message.tr(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(LocaleKeys.meals_dialogs_cancel.tr()),
        ),
        TextButton(
          onPressed: onDelete,
          child: Text(
            LocaleKeys.meals_dialogs_delete.tr(),
            style: const TextStyle(color: Colors.brown),
          ),
        ),
      ],
    );
  }
}
