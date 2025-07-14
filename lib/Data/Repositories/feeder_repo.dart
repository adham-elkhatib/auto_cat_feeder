import '../../core/Providers/FB RTDB/fbrtdb_repo.dart';
import '../../features/feeder/data/models/feeder_model.dart';

class FeederRepo extends RTDBRepo<FeederModel> {
  FeederRepo()
      : super(
          path: "Devices",
          discardKey: true,
        );

  @override
  FeederModel? toModel(Object? data) {
    return FeederModel.fromMap((data as Map<Object?, Object?>?)
            ?.map((key, value) => MapEntry(key.toString(), value)) ??
        {});
  }

  @override
  Map<String, dynamic>? fromModel(FeederModel? item) => item?.toMap() ?? {};
}
