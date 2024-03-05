part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitial  extends LocationState {}

class BusLocationStartState extends LocationState{}

class BusLocationStopState extends LocationState{}
