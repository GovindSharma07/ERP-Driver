import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erp_driver/features/services/location_service.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';



class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<BusLocationStartEvent>(_busLocationStartEvent);
  on<BusLocationStopEvent>(_busLocationStopEvent);
  }

  FutureOr<void> _busLocationStartEvent(BusLocationStartEvent event, Emitter<LocationState> emit) async{
    int checkService = await checkLocationService();
    if(checkService == 0){
      return;
    }

startLocationListening(event.tokens);
    emit(BusLocationStartState());
  }

  FutureOr<void> _busLocationStopEvent(BusLocationStopEvent event, Emitter<LocationState> emit) {
  stopLocationListening();
    emit(BusLocationStopState());
  }
}


