
import 'package:flutter/material.dart';
import 'package:jeevan_weather_task/utils/utils.dart';
import '../utils/dimens.dart';

/// A widget which will be used in the forms to allow user to submit the
/// details which were filled by the user.
///
/// [opacity] : The opacity of the widget to show that the widget is not enabled.
/// [disableColor] : The disable color of the widget.
/// [padding] : The padding around the content of the widget.
/// [onTap] : The tap event which will be triggered.
/// [text] : The text which will be shown.
/// [textStyle] : The style of the [text].
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.opacity = 1,
    this.disableColor,
    this.startColor,
    this.endColor,
    this.iconPath,
    this.iconColor,
    this.borderWidth,
    this.borderColor,
    this.padding,
    this.onTap,
    required this.text,
    this.textStyle,
    this.autoFocus = false,
    required this.buttonColor,
    this.containerMargin,
  });

  final double opacity;
  final Color? disableColor;
  final Color? startColor;
  final Color? endColor;
  final String? iconPath;
  final Color? iconColor;
  final double? borderWidth;
  final Color? borderColor;
  final EdgeInsets? padding;
  final void Function()? onTap;
  final String? text;
  final TextStyle? textStyle;
  final bool autoFocus;
  final Color buttonColor;
  final EdgeInsets? containerMargin;

  @override
  Widget build(BuildContext context) => Opacity(
      opacity: opacity,
      child: Container(
        margin: containerMargin ?? Dimens.edgeInsets0_0_0_0,
        decoration: BoxDecoration(
          /* boxShadow: [
              const BoxShadow(
                  color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
            ],*/
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   stops: [0.0, 1.0],
          //   colors: [
          //     endColor!,
          //     startColor!,
          //   ],
          // ),
          color: buttonColor,
          border: Border.all(
              width: borderWidth ?? 0,
              color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(Dimens.ten),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.ten),
              ),
            ),
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(padding ?? Dimens.edgeInsets0_0_0_0),
            //minimumSize: MaterialStateProperty.all(Size(width, 50)),
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            // elevation: MaterialStateProperty.all(3),
            shadowColor: WidgetStateProperty.all(Colors.transparent),
          ),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    text!,
                    style: textStyle,
                  ),
                  if (iconPath != null && iconPath!.isNotEmpty)
                    SizedBox(width: Dimens.five),
                  if (iconPath != null && iconPath!.isNotEmpty)
                    Image(
                      color: iconColor!,
                      width: Dimens.twenty,
                      height: Dimens.twenty,
                      image: AssetImage(iconPath!),
                    ),
                ],
              ),
            ],
          ),
        ),
      ));
}