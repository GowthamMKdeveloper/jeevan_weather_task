import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevan_weather_task/bloc/login_bloc/login_bloc.dart';
import 'package:jeevan_weather_task/bloc/weather_bloc/weather_bloc.dart';
import 'package:jeevan_weather_task/routes/routes.dart';
import 'package:jeevan_weather_task/ui/login_screen/login_screen.dart';

void main() {

  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LoginBloc()),
            BlocProvider(create: (context) => WeatherBloc()),
          ],
          child: MaterialApp(
            home: const LoginScreen(),
            routes: Routes.getRoutes(),
          )));

}
