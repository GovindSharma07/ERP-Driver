part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}

class BusLocationStartEvent extends LocationEvent{
  final List<String> tokens;
  BusLocationStartEvent(this.tokens);
}

class BusLocationStopEvent extends LocationEvent{}

