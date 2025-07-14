part of 'feeder_bloc.dart';

abstract class FeederEvent extends Equatable {
  const FeederEvent();

  @override
  List<Object?> get props => [];
}

class StreamFeederStatusEvent extends FeederEvent {
  final String feederId;

  const StreamFeederStatusEvent({required this.feederId});

  @override
  List<Object?> get props => [feederId];
}
