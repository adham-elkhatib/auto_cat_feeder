import '../../../../core/Providers/FB RTDB/fbrtdb_repo.dart';
import '../../../../core/Services/Error Handling/exports.error_handling.dart';
import '../models/feeder_model.dart';

abstract class FeederRemoteDataSource {
  Future<FeederModel> getFeeder({required String feederId});

  Future<void> syncToFeeder({required FeederModel feeder});

  Future<void> connectFeeder({required FeederModel feeder});

  Future<void> disconnectFeeder({required String feederId});

  Stream<FeederModel> streamFeeder({required String feederId});
}

class FeederRemoteDataSourceImpl implements FeederRemoteDataSource {
  final RTDBRepo<FeederModel> db;

  FeederRemoteDataSourceImpl({required this.db});

  @override
  Future<FeederModel> getFeeder({required String feederId}) async {
    try {
      final data = await db.read(feederId);
      if (data == null) {
        throw ServerException(message: "Feeder not found");
      }
      return data;
    } catch (e) {
      throw ServerException(
        message: "Failed to fetch feeder: ${e.toString()}",
      );
    }
  }

  @override
  Future<void> connectFeeder({required FeederModel feeder}) async {
    try {
      await db.create(feeder, key: feeder.id, generateKey: false);
      return;
    } catch (e) {
      throw ServerException(
        message: "Failed to create feeder: ${e.toString()}",
      );
    }
  }

  @override
  Future<void> syncToFeeder({required FeederModel feeder}) async {
    try {
      await db.update(feeder.id, feeder);
      return;
    } catch (e) {
      throw ServerException(
        message: "Failed to update feeder: ${e.toString()}",
      );
    }
  }

  @override
  Stream<FeederModel> streamFeeder({required String feederId}) {
    return db.watch().map(
      (list) {
        final matched = list?.whereType<FeederModel>().firstWhere(
              (f) => f.id == feederId,
              orElse: () => throw ServerException(message: "Feeder not found"),
            );
        return matched!;
      },
    );
  }

  @override
  Future<void> disconnectFeeder({required String feederId}) async {
    try {
      await db.delete(feederId);
      return;
    } catch (e) {
      throw ServerException(
        message: "Failed to create feeder: ${e.toString()}",
      );
    }
  }
}
