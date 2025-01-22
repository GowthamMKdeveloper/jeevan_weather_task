
import 'package:flutter/material.dart';
import 'package:jeevan_weather_task/model/weather_model/weather_data_components.dart';
import 'package:jeevan_weather_task/styles/styles.dart';
import 'package:jeevan_weather_task/utils/utils.dart';

class WeatherDataListview extends StatefulWidget {
  const WeatherDataListview({
    super.key,
    required this.weatherDataComponents
  });

  final WeatherDataComponents weatherDataComponents;

  @override
  State<WeatherDataListview> createState() => _WeatherDataListviewState();
}

class _WeatherDataListviewState extends State<WeatherDataListview> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height/1.29,
      width: MediaQuery.sizeOf(context).width,
      // color: AppColors.pinkColorshade200,
      child: ListView.builder(
        itemCount: widget.weatherDataComponents.hourly!.time!.length,
        itemBuilder: (context, index) {
          return Container(
            height: Dimens.hundred,
            margin: Dimens.edgeInsets5_0_5_0,
            width: MediaQuery.sizeOf(context).width,
            child: Card(
              elevation: Dimens.ten,
              child: Container(
                margin: Dimens.edgeInsets5_0_5_0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("${StringConstants.time} : ${widget.weatherDataComponents.hourly!.
                    time![index].toString()}", style: AppTextStyles.black16Bold),

                    Text("${StringConstants.temperature} : ${widget.weatherDataComponents.hourly!.
                    temperature2m![index].toString()}°C", style: AppTextStyles.black16Bold),

                    Text("${StringConstants.weatherCode} : ${widget.weatherDataComponents.hourly!.
                    weathercode![index].toString()}", style: AppTextStyles.black16Bold),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
