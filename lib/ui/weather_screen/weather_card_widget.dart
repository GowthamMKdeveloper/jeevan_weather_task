import 'package:flutter/material.dart';
import 'package:jeevan_weather_task/styles/styles.dart';
import 'package:jeevan_weather_task/utils/utils.dart';

class WeatherCardWidget extends StatefulWidget {
  const WeatherCardWidget({
    super.key,
    required this.address,});
  final String address;

  @override
  State<WeatherCardWidget> createState() => _WeatherCardWidgetState();
}

class _WeatherCardWidgetState extends State<WeatherCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Dimens.edgeInsets5_0_5_0,
      width: MediaQuery.sizeOf(context).width,
      // height: Dimens.hundred + Dimens.fifty,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.yellowColorShade50, // Start color
            AppColors.yellowColorShade100, // Start color
            AppColors.yellowColorShade200,  // End color
            AppColors.yellowColorShade300,  // End color
            AppColors.yellowColorShade400,  // End color
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        margin: Dimens.edgeInsets10_0_10_0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("\t\t\t${StringConstants.hiWelcomeToBack}",
                style: AppTextStyles.black20W800),

            Text(widget.address.toString(),
            style: AppTextStyles.black20W800),

             /*Dimens.boxHeight10,
            Text(widget.placeMark.locality.toString(),
                style: AppTextStyles.black20W800),

             Dimens.boxHeight10,
            Text(widget.placeMark.administrativeArea.toString(),
                style: AppTextStyles.black20W800),*/

          ],
        ),
      ),
    );
  }
}
