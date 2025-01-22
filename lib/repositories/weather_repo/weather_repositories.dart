import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jeevan_weather_task/model/weather_model/weather_data_components.dart';
import 'package:jeevan_weather_task/model/weather_model/weather_response.dart';
import 'package:jeevan_weather_task/repositories/app_config.dart';
import 'package:jeevan_weather_task/utils/utils.dart';


class WeatherRepository {

  Future<WeatherResponse> fetchWeatherData(apiEndPoint) async {
    try {

      final response = await http.get(
        Uri.parse("${AppConfig.baseUrl}$apiEndPoint"),
        headers: {'Content-Type': 'application/json'},
        // body: json.encode(body),
      );
      Utility.printDLog("fetchWeatherData Response : ${response.body}");
      Utility.printDLog("fetchWeatherData Url : ${AppConfig.baseUrl}$apiEndPoint");
      if (response.statusCode==200) {
        // List<dynamic> jsonResponse = json.decode(response.body);
        // return jsonResponse.map((json) => WeatherResponse.fromJson(json)).toList();
        // return WeatherResponseFromJson(response.body);
        return WeatherResponse(weatherDataComponents:
        WeatherDataComponents.fromJson(jsonDecode(response.body)), message: "successfully fetched",
        statusCode: 200);
      } else {
        return WeatherResponse(message: "Something went Wrong.!!",
            statusCode: response.statusCode, weatherDataComponents: null);
      }

    } on SocketException {
      return WeatherResponse(message: StringConstants.unableToConnectTheServer, statusCode: 401,
          weatherDataComponents: null);
    }
    catch (error, stacktrace) {
      Utility.printELog("Exception occurred: $error stackTrace: $stacktrace");
      return WeatherResponse(message: error.toString(), statusCode: 401,
          weatherDataComponents: null);
    }
  }

}