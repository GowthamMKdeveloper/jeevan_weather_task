
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jeevan_weather_task/bloc/weather_bloc/weather_event.dart';
import 'package:jeevan_weather_task/bloc/weather_bloc/weather_state.dart';
import 'package:jeevan_weather_task/repositories/weather_repo/weather_repositories.dart';
import 'package:jeevan_weather_task/utils/utils.dart';
import 'package:location/location.dart' as location;

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  WeatherRepository weatherRepository = WeatherRepository();

  WeatherBloc() : super(WeatherState()) {
    on<WeatherLocationPermissionRequest>((event, emit) => _requestLocationPermission(event, emit));
    on<WeatherGetCurrentLocation>((event, emit) => _getCurrentLocation(event, emit));
    on<WeatherFetchLatLngBaseAddress>((event, emit) => _getAddressLatLngBase(event, emit));
    on<WeatherDataFetchEvent>((event, emit) => _fetchWeatherData(event,emit));
  }


  void _requestLocationPermission(WeatherLocationPermissionRequest event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());
    location.Location locationPlugin = location.Location();

    await locationPlugin.requestPermission();

    location.PermissionStatus permissionStatus =
    await locationPlugin.hasPermission();

    if (permissionStatus == location.PermissionStatus.denied) {
      permissionStatus = await locationPlugin.requestPermission();
      if (permissionStatus == location.PermissionStatus.denied) {
        emit(WeatherCloseLoading());
        emit(WeatherLocationPermissionError(
            errorMessage: "Permission Denied Please Enable Permission.!!"));
      } else if (permissionStatus == location.PermissionStatus.deniedForever) {
        emit(WeatherCloseLoading());
        emit(WeatherLocationPermissionError(
            errorMessage: "Permission Denied Please Enable Permission.!!"));
      }
    } else if (permissionStatus == location.PermissionStatus.deniedForever) {
      emit(WeatherCloseLoading());
      emit(WeatherLocationPermissionError(
          errorMessage: "Permission Denied Please Enable Permission.!!"));
    } else if (permissionStatus == location.PermissionStatus.granted) {
      emit(WeatherCloseLoading());
      emit(WeatherLocationPermissionGranted(
          message: "Permission Granted..."));
    }


  }

  void _getCurrentLocation(WeatherGetCurrentLocation event, Emitter<WeatherState> emit) async {
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high)
    );
    emit(CurrentLocationFetchSuccess(
        latLng: LatLng(position.latitude, position.longitude)));
  }

  void _getAddressLatLngBase(WeatherFetchLatLngBaseAddress event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());
    await placemarkFromCoordinates(event.latLng.latitude, event.latLng.longitude)
        .then((List<Placemark> placeMarks) {
      Placemark place = placeMarks[0];
      String address =
          '${place.street}, ${place.subLocality}, ${place.locality},'
          '${place.administrativeArea}, ${place.postalCode}';
      emit(WeatherCloseLoading());
      emit(WeatherFetchLatLngBaseAddressSuccess(placeMark: place, address: address));

    }).catchError((exception, stackTrace) {
      emit(WeatherCloseLoading());
      emit(WeatherFetchLatLngBaseAddressFailure(errorMessage: exception));
      Utility.printELog("Exception : $exception StackTrace $stackTrace");
    });
  }

  void _fetchWeatherData(WeatherDataFetchEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());
    // WeatherDataComponents weatherDataComponents;
    try {
      var response = await weatherRepository.fetchWeatherData("forecast?latitude=${event.latLng.latitude.toString()}&longitude=${event.latLng.longitude.toString()}&hourly=temperature_2m,weathercode");
      if (response.statusCode == 200) {
        emit(WeatherCloseLoading());
        // weatherDataComponents = response.weatherDataComponents!;
        emit(WeatherDataFetchSuccessfully(weatherDataComponents: response.weatherDataComponents!));
      } else {
        emit(WeatherCloseLoading());
        emit(WeatherDataFetchFailure(errorMessage: response.message.toString()));
      }
    } catch (e) {
      emit(WeatherCloseLoading());
      emit(WeatherDataFetchFailure(errorMessage: e.toString()));
    }


  }

}