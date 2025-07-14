import 'package:dartz/dartz.dart';

import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../entities/feeder_entity.dart';
import '../repositories/feeder_repository.dart';

class StreamFeeder {
  final FeederRepository feederRepository;

  StreamFeeder({required this.feederRepository});

  Stream<Either<Failure, FeederEntity>> call({required String feederId}) {
    return feederRepository.streamFeeder(feederId: feederId);
  }
}
