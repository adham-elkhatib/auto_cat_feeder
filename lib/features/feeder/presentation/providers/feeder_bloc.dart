import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/feeder_entity.dart';
import '../../domain/usecases/stream_feeder.dart';

part 'feeder_event.dart';
part 'feeder_state.dart';

class FeederBloc extends Bloc<FeederEvent, FeederState> {
  final StreamFeeder streamFeederUseCase;

  FeederBloc({
    required this.streamFeederUseCase,
  }) : super(FeederInitial()) {
    on<StreamFeederStatusEvent>(_onStreamFeederStatus);
  }

  Future<void> _onStreamFeederStatus(
    StreamFeederStatusEvent event,
    Emitter<FeederState> emit,
  ) async {
    emit(FeederConnecting());
    final stream = streamFeederUseCase(feederId: event.feederId);

    await emit.forEach(
      stream,
      onData: (result) => result.fold(
        (failure) => FeederError(message: failure.message),
        (feeder) => FeederStatusUpdated(feeder: feeder),
      ),
    );
  }
}
