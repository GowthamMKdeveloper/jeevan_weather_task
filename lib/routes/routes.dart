
import 'package:flutter/material.dart';
import 'package:jeevan_weather_task/ui/ui.dart';



abstract class Routes {


  static const String loginScreen = '/login_screen';
  static const String weatherScreen = '/weather_screen';



  static Map<String, WidgetBuilder> getRoutes() {
  return {

    loginScreen: (context) => const LoginScreen(),
    weatherScreen: (context) => const WeatherScreen(),

  };

  }


}