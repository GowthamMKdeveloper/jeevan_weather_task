import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevan_weather_task/bloc/login_bloc/login_bloc.dart';
import 'package:jeevan_weather_task/bloc/login_bloc/login_state.dart';
import 'package:jeevan_weather_task/routes/routes.dart';
import 'package:jeevan_weather_task/styles/styles.dart';
import 'package:jeevan_weather_task/utils/utils.dart';
import 'package:jeevan_weather_task/widgets/widgets.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.sizeOf(context).height;
    var width =  MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginInitialState) {

          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Dimens.boxHeight20,
            Center(
              child: Text(StringConstants.login,
              style: AppTextStyles.black20Bold),
            ),

            Dimens.boxHeight50,
            Dimens.boxHeight50,

            // UserName Widget
            TextFieldWidget(
              fieldWidth: width/1.1,
              fieldHeight: height/20,
              hintText: StringConstants.userName,
              contentPadding: EdgeInsets.only(left: Dimens.ten),
              formBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.five))
              ),
            ),


            Dimens.boxHeight20,
            Dimens.boxHeight10,


            // Password Widget
            TextFieldWidget(
              fieldWidth: width/1.1,
              fieldHeight: height/20,
              hintText: StringConstants.password,
              contentPadding: EdgeInsets.only(left: Dimens.ten),
              formBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Dimens.five))
              ),
            ),

            Dimens.boxHeight20,
            Dimens.boxHeight10,

            //Submit Button Widget
            ButtonWidget(
              text: StringConstants.login,
              textStyle: AppTextStyles.black20W800,
              buttonColor: AppColors.primaryColor,
              containerMargin: Dimens.edgeInsets50_0_50_0,
              onTap: () {
                Navigator.pushNamed(context, Routes.weatherScreen);
              },
            )


          ],
        ),
      ),
    );
  }
}
