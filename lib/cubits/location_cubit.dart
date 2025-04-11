import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../states/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> checkLocationPermission(BuildContext context) async {
    emit(LocationLoading());

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      emit(LocationServiceDisabled());
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        emit(LocationPermissionDenied());
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(LocationPermissionDeniedForever());
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      emit(LocationPermissionGranted());
      return;
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      emit(LocationFetched(position));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  Future<void> manualLocationInput(String address) async {

  }
}
