import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../Model/App User/app_user.model.dart';
import '../Model/Cat/cat.model.dart';

class CatRepo extends FirestoreRepo<Cat> {
  CatRepo()
      : super(
          'cats',
        );

  @override
  Cat? toModel(Map<String, dynamic>? item) => Cat.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(Cat? item) => item?.toMap() ?? {};
}
