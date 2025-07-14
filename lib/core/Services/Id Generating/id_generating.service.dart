import 'package:min_id/min_id.dart';

class IdGeneratingService {
  static const String defaultPattern = '{16{w}}';

  static String generate({
    String? pattern,
  }) {
    return MinId.getId(pattern ?? defaultPattern);
  }
}
