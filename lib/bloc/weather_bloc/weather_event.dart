
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WeatherEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WeatherEventInitial extends WeatherEvent {}

class WeatherLocationPermissionRequest extends WeatherEvent {}

class WeatherGetCurrentLocation extends WeatherEvent {}

class WeatherFetchLatLngBaseAddress extends WeatherEvent {
  final LatLng latLng;
  WeatherFetchLatLngBaseAddress({required this.latLng});
  @override
  List<Object> get props => [latLng];
}

class WeatherDataFetchEvent extends WeatherEvent {
  final LatLng latLng;
  WeatherDataFetchEvent({required this.latLng});
  @override
  List<Object> get props => [latLng];
}