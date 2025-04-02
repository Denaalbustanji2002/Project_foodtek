import 'package:geolocator/geolocator.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Position position;

  LocationLoaded(this.position);
}

class LocationServiceDisabled extends LocationState {}//gps disabled

class LocationPermissionDenied extends LocationState {} // user denied permission

class LocationPermissionPermanentlyDenied extends LocationState {} // user denied permission permanently

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}//gps error
