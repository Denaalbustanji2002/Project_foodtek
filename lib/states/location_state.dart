import 'package:geolocator/geolocator.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationServiceDisabled extends LocationState {}

class LocationPermissionDenied extends LocationState {}

class LocationPermissionDeniedForever extends LocationState {}

class LocationPermissionGranted extends LocationState {}

class LocationFetched extends LocationState {
  final Position position;

  LocationFetched(this.position);
}

class LocationError extends LocationState {
  final String errorMsg;

  LocationError(this.errorMsg);
}