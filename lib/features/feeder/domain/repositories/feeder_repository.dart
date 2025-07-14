import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/feeder/feeder_params.dart';
import '../entities/feeder_entity.dart';

abstract class FeederRepository {
  Future<Either<Failure, FeederEntity>> getFeeder({
    required String feederId,
  });

  Future<Either<Failure, void>> syncToFeeder({
    required SyncToFeederParams params,
  });

  Future<Either<Failure, void>> connectFeeder({
    required String feederId,
  });

  Future<Either<Failure, void>> disconnectFeeder({
    required String feederId,
  });

  Stream<Either<Failure, FeederEntity>> streamFeeder(
      {required String feederId});
}
