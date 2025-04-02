
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../states/location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  LocationCubit() : super(LocationInitial());

  Future<void> requestLocation() async {
    emit(LocationLoading());
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(LocationServiceDisabled());
        return;
      }//gps disabled

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationPermissionDenied());
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationPermissionPermanentlyDenied());
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      emit(LocationLoaded(position));

      // Save the location securely
      await _storage.write(key: 'latitude', value: position.latitude.toString());
      await _storage.write(key: 'longitude', value: position.longitude.toString());
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  Future<void> loadSavedLocation() async {
    emit(LocationLoading());
    try {
      String? latitude = await _storage.read(key: 'latitude');
      String? longitude = await _storage.read(key: 'longitude');

      if (latitude != null && longitude != null) {
        Position savedPosition = Position(
          latitude: double.parse(latitude),
          longitude: double.parse(longitude),
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          headingAccuracy: 0,
          altitudeAccuracy: 0,
        );
        emit(LocationLoaded(savedPosition));
      } else {
        emit(LocationError('No saved location found.'));
      }
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}
