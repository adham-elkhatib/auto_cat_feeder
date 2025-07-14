import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../entities/feeder_entity.dart';
import '../repositories/feeder_repository.dart';

class GetFeeder {
  final FeederRepository feederRepository;

  GetFeeder({required this.feederRepository});

  Future<Either<Failure, FeederEntity>> call({
    required String feederId,
  }) async {
    return await feederRepository.getFeeder(feederId: feederId);
  }
}
