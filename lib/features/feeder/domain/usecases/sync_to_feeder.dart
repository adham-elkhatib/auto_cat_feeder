import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../../../../core/params/feeder/feeder_params.dart';
import '../repositories/feeder_repository.dart';

class SyncToFeeder {
  final FeederRepository feederRepository;

  SyncToFeeder({required this.feederRepository});

  Future<Either<Failure, void>> call({
    required SyncToFeederParams params,
  }) async {
    return await feederRepository.syncToFeeder(params: params);
  }
}
