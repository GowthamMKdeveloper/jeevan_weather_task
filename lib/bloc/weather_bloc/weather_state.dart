
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jeevan_weather_task/model/weather_model/weather_data_components.dart';

class WeatherState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WeatherStateInitial extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherCloseLoading extends WeatherState {}

class WeatherDataFetchFailure extends WeatherState {
  final String errorMessage;
  WeatherDataFetchFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];

}

class WeatherLocationPermissionError extends WeatherState {
  final String errorMessage;
  WeatherLocationPermissionError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class WeatherLocationPermissionGranted extends WeatherState {
  final String message;
  WeatherLocationPermissionGranted({required this.message});
  @override
  List<Object> get props => [message];
}

class CurrentLocationFetchSuccess extends WeatherState {
  final LatLng latLng;
  CurrentLocationFetchSuccess({required this.latLng});
  @override
  List<Object> get props => [latLng];
}

class WeatherFetchLatLngBaseAddressSuccess extends WeatherState {
  final Placemark placeMark;
  final String address;
  WeatherFetchLatLngBaseAddressSuccess({required this.placeMark, required this.address});
  @override
  List<Object> get props => [placeMark, address];
}

class WeatherFetchLatLngBaseAddressFailure extends WeatherState {
  final String errorMessage;
  WeatherFetchLatLngBaseAddressFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class WeatherDataFetchSuccessfully extends WeatherState {
  late final WeatherDataComponents weatherDataComponents;
  WeatherDataFetchSuccessfully({required this.weatherDataComponents});
  @override
  List<Object> get props => [weatherDataComponents];

}