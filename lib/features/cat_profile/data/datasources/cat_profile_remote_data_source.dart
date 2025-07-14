import '../../../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../models/cat_model.dart';

abstract class CatRemoteDataSource {
  Future<CatModel> createCatProfile(CatModel model);

  Future<CatModel> getCat(String id);

  Future<CatModel> updateCatProfile(CatModel model);
}

class CatRemoteDataSourceImpl implements CatRemoteDataSource {
  final FirestoreRepo<CatModel> firestoreRepo;

  CatRemoteDataSourceImpl({required this.firestoreRepo});

  @override
  Future<CatModel> createCatProfile(CatModel model) async {
    try {
      await firestoreRepo.createSingle(model, itemId: model.id);

      return model;
    } catch (e) {
      throw ServerException(
        message: "Failed to create cat profile: ${e.toString()}",
      );
    }
  }

  @override
  Future<CatModel> getCat(String id) async {
    try {
      final data = await firestoreRepo.readSingle(id);
      if (data == null) {
        throw ServerException(message: "Cat profile not found");
      }
      return data;
    } catch (e) {
      throw ServerException(
        message: "Failed to fetch profile: ${e.toString()}",
      );
    }
  }

  @override
  Future<CatModel> updateCatProfile(CatModel model) async {
    try {
      await firestoreRepo.updateSingle(model.id, model);
      return model;
    } catch (e) {
      throw ServerException(
        message: "Failed to update cat profile: ${e.toString()}",
      );
    }
  }
}
