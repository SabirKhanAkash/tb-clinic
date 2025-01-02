import 'package:flutter/material.dart';
import 'package:tb_clinic/utils/config/app_text.dart';

class CustomButtonOne extends StatelessWidget {
  final String buttonLabel;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? buttonClickAction;

  const CustomButtonOne({
    Key? key,
    required this.buttonLabel,
    this.backgroundColor,
    this.foregroundColor,
    this.buttonClickAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        minimumSize: MaterialStateProperty.all(Size(double.maxFinite, double.minPositive)),
        padding: MaterialStateProperty.all(EdgeInsets.only(top: 15, bottom: 15)),
      ),
      onPressed: buttonClickAction,
      // onPressed: () async => await cubit.login(AuthDto(
      //     username: userNameController.text, password: passwordController.text)),
      child: Text(
        buttonLabel,
        style: TextStyle(
          fontSize: AppText().largeFontSize,
          fontFamily: AppText().primaryFont,
        ),
      ),
    );
  }
}
