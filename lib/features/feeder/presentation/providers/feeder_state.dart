part of 'feeder_bloc.dart';

abstract class FeederState extends Equatable {
  const FeederState();

  @override
  List<Object?> get props => [];
}

class FeederInitial extends FeederState {}

class FeederConnecting extends FeederState {}

class FeederConnected extends FeederState {
  final String feederId;

  const FeederConnected({required this.feederId});

  @override
  List<Object?> get props => [feederId];
}

class FeederSyncing extends FeederState {}

class FeederSynced extends FeederState {}

class FeederDisconnecting extends FeederState {}

class FeederDisconnected extends FeederState {}

class FeederError extends FeederState {
  final String message;

  const FeederError({required this.message});

  @override
  List<Object?> get props => [message];
}

class FeederStatusUpdated extends FeederState {
  final FeederEntity feeder;

  const FeederStatusUpdated({required this.feeder});

  @override
  List<Object?> get props => [feeder];
}
