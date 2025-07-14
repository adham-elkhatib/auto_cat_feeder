import '../../../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> createProfile(UserModel model);

  Future<UserModel> getProfile(String uid);

  Future<UserModel> updateProfile(UserModel model);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirestoreRepo<UserModel> firestoreRepo;

  ProfileRemoteDataSourceImpl({required this.firestoreRepo});

  @override
  Future<UserModel> createProfile(UserModel model) async {
    try {
      await firestoreRepo.createSingle(model, itemId: model.id);
      return model;
    } catch (e) {
      throw ServerException(
        message: "Failed to create profile: ${e.toString()}",
      );
    }
  }

  @override
  Future<UserModel> getProfile(String uid) async {
    try {
      final data = await firestoreRepo.readSingle(uid);
      if (data == null) {
        throw ServerException(message: "Profile not found");
      }
      return data;
    } catch (e) {
      throw ServerException(
        message: "Failed to fetch profile: ${e.toString()}",
      );
    }
  }

  @override
  Future<UserModel> updateProfile(UserModel model) async {
    try {
      await firestoreRepo.updateSingle(model.id, model);
      return model;
    } catch (e) {
      throw ServerException(
        message: "Failed to update profile: ${e.toString()}",
      );
    }
  }
}
