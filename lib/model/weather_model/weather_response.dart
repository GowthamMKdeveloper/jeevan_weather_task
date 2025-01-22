
import 'package:jeevan_weather_task/model/weather_model/weather_data_components.dart';

class WeatherResponse {
  int? statusCode;
  String? message;
  WeatherDataComponents? weatherDataComponents;

  WeatherResponse({this.statusCode, this.message, this.weatherDataComponents});
}