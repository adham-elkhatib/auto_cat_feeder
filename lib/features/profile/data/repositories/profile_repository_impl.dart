import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/profile/profile_params.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/user_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> getProfile(
      {required ProfileParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        UserModel remoteProfile = await remoteDataSource.getProfile(params.id);

        await localDataSource.cacheProfile(profileToCache: remoteProfile);

        return Right(remoteProfile.toEntity());
      } on ServerException {
        return Left(
            ServerFailure(message: 'This is a server exception', code: 500));
      }
    } else {
      try {
        UserModel localProfile = await localDataSource.getLastProfile();
        return Right(localProfile.toEntity());
      } on CacheException {
        return Left(CacheFailure(
          message: 'This is a cache exception',
        ));
      }
    }
  }

  @override
  Future<Either<Failure, void>> createProfile(
      {required CreateProfileParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        final model = UserModel(
          id: params.id,
          email: params.email,
          fName: params.fName,
          lName: params.lName,
          phoneNumber: params.phoneNumber,
        );
        UserModel remoteProfile = await remoteDataSource.createProfile(model);

        await localDataSource.cacheProfile(profileToCache: remoteProfile);

        return const Right(null);
      } on ServerException {
        return Left(
            ServerFailure(message: 'This is a server exception', code: 500));
      }
    }
    return Left(
      NetworkFailure(
        message: "You are not connected to the internet",
      ),
    );
  }

  @override
  Future<Either<Failure, void>> updateProfile(
      {required UpdateProfileParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        final model = UserModel(
          id: params.id,
          email: params.email,
          fName: params.fName,
          lName: params.lName,
          phoneNumber: params.phoneNumber,
        );
        UserModel remoteProfile = await remoteDataSource.updateProfile(model);

        await localDataSource.cacheProfile(profileToCache: remoteProfile);

        return const Right(null);
      } on ServerException {
        return Left(
            ServerFailure(message: 'This is a server exception', code: 500));
      }
    }
    return Left(
      NetworkFailure(
        message: "You are not connected to the internet",
      ),
    );
  }
}
