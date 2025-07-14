import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../../features/cat_profile/data/models/cat_model.dart';

class CatRepo extends FirestoreRepo<CatModel> {
  CatRepo()
      : super(
          'cats',
        );

  @override
  CatModel? toModel(Map<String, dynamic>? item) => CatModel.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(CatModel? item) => item?.toMap() ?? {};
}
