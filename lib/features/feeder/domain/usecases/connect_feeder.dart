import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../repositories/feeder_repository.dart';

class ConnectToFeeder {
  final FeederRepository feederRepository;

  ConnectToFeeder({required this.feederRepository});

  Future<Either<Failure, void>> call({
    required String feederId,
  }) async {
    return await feederRepository.connectFeeder(feederId: feederId);
  }
}
