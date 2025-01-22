import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jeevan_weather_task/bloc/weather_bloc/weather_bloc.dart';
import 'package:jeevan_weather_task/bloc/weather_bloc/weather_event.dart';
import 'package:jeevan_weather_task/bloc/weather_bloc/weather_state.dart';
import 'package:jeevan_weather_task/enums/app_enums.dart';
import 'package:jeevan_weather_task/styles/styles.dart';
import 'package:jeevan_weather_task/utils/utils.dart';
import 'weather_screen_export.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  Placemark? placeMark;
  String? address;
  LatLng? latLng;

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherLocationPermissionRequest());
  }

  @override
  void dispose() {
    super.dispose();

  }




  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.forecastReport),
      ),
      body: SingleChildScrollView(
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherLoadingState) {
              Utility.showLoadingDialog(context);
            } else if (state is WeatherCloseLoading) {
              Utility.hideDialog(context);
            } else if (state is WeatherLocationPermissionGranted) {
              Utility.showSnackbar(context, state.message, TypeOfMessage.success);
              context.read<WeatherBloc>().add(WeatherGetCurrentLocation());
            } else if (state is WeatherLocationPermissionError) {
              Utility.showSnackbar(context, state.errorMessage, TypeOfMessage.error);
            } else if (state is CurrentLocationFetchSuccess) {
              latLng = state.latLng;
              context.read<WeatherBloc>().add(WeatherFetchLatLngBaseAddress(latLng: state.latLng));
            } else if (state is WeatherFetchLatLngBaseAddressFailure) {
              Utility.showSnackbar(context, state.errorMessage, TypeOfMessage.error);
            }
          },
          child: Column(
            children: [

              BlocConsumer<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                  if (state is WeatherFetchLatLngBaseAddressSuccess) {
                    return WeatherCardWidget(address: address!);
                  }
                  return SizedBox(
                    height: Dimens.thirty,
                      width: Dimens.thirty,
                      child: CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                        strokeWidth: Dimens.five,
                      ),);
                },
                  listener: (context, state) {
                    if (state is WeatherFetchLatLngBaseAddressSuccess) {
                      placeMark = state.placeMark;
                      address = state.address;
                      context.read<WeatherBloc>().add(WeatherDataFetchEvent(latLng: latLng!));
                    }
                  },
                buildWhen: (context, state) {
                    return state is WeatherFetchLatLngBaseAddressSuccess;
                },
                listenWhen: (context, state) {
                  return state is WeatherFetchLatLngBaseAddressSuccess;
                },
              ),


              Dimens.boxHeight10,
              BlocConsumer<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherDataFetchSuccessfully) {
                      return WeatherDataListview(
                        weatherDataComponents: state.weatherDataComponents,);
                    } else {
                      return Center(
                        child: Container(
                          height: height,
                          width: width,
                          alignment: Alignment.center,
                          child: Text("${StringConstants.noDataFound}.!!",
                            style: AppTextStyles.black20W800,),
                        ),
                      );
                    }

                  },
                  listenWhen: (context, state) {
                    return state is WeatherDataFetchSuccessfully ||
                        state is WeatherDataFetchFailure;
                  },

                  buildWhen: (context, state) {
                    return state is WeatherDataFetchSuccessfully ||
                    state is WeatherDataFetchFailure;
                  },

                  listener: (context, state) {
                    if (state is WeatherDataFetchFailure) {
                      Utility.showSnackbar(context, state.errorMessage, TypeOfMessage.error);
                    }
                  }

                  )


            ],
          ),
        ),
      ),
    );



  }

}
