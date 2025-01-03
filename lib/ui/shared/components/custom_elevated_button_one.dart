import 'package:flutter/material.dart';
import 'package:tb_clinic/utils/config/app_style.dart';

class CustomElevatedButtonOne extends StatelessWidget {
  final String buttonLabel;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? buttonClickAction;

  const CustomElevatedButtonOne({
    super.key,
    required this.buttonLabel,
    this.backgroundColor,
    this.foregroundColor,
    this.buttonClickAction,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        foregroundColor: WidgetStateProperty.all(foregroundColor),
        minimumSize: WidgetStateProperty.all(const Size(double.maxFinite, double.minPositive)),
        padding: WidgetStateProperty.all(const EdgeInsets.only(top: 15, bottom: 15)),
      ),
      onPressed: buttonClickAction,
      child: Text(
        buttonLabel,
        style: TextStyle(
          fontSize: AppStyle().largeDp,
          fontFamily: AppStyle().primaryFont,
        ),
      ),
    );
  }
}
