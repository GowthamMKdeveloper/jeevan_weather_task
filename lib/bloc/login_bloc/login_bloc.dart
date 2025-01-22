
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevan_weather_task/bloc/login_bloc/login_event.dart';
import 'package:jeevan_weather_task/bloc/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginInitialState()) {
    on<LoginEvent>((event, state) => _initialFunction(event, state));
  }

  void _initialFunction(LoginEvent event, Emitter<LoginState> state) {

  }

}