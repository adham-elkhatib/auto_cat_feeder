import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../domain/entities/meal_entity.dart';

class EditServingAlertDialog extends StatelessWidget {
  final MealEntity meal;

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
      title: Text(LocaleKeys.meals_dialogs_edit_title.tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(LocaleKeys.meals_dialogs_edit_description.tr()),
          const SizedBox(height: 16),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: LocaleKeys.meals_dialogs_edit_label.tr(),
              border: const UnderlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(LocaleKeys.meals_dialogs_cancel.tr()),
        ),
        TextButton(
          onPressed: () {
            if (amountController.text.isNotEmpty) {
              final newServing = int.tryParse(amountController.text);
              if (newServing != null && newServing > 0) {
                Navigator.pop(context, meal.copyWith(serving: newServing));
              } else {
                SnackbarHelper.showError(
                  context,
                  title: LocaleKeys.meals_dialogs_edit_error.tr(),
                );
              }
            }
          },
          child: Text(LocaleKeys.meals_dialogs_save.tr()),
        ),
      ],
    );
  }
}
