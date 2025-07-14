import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../../features/meals/data/models/meal_model.dart';

class MealRepo extends FirestoreRepo<MealModel> {
  MealRepo()
      : super(
          'meals',
        );

  @override
  MealModel? toModel(Map<String, dynamic>? item) =>
      MealModel.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(MealModel? item) => item?.toMap() ?? {};
}
