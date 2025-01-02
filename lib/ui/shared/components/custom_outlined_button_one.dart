import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_text.dart';

class CustomOutLinedButtonOne extends StatelessWidget {
  final String? prefixIcon;
  final String buttonLabel;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? buttonClickAction;

  const CustomOutLinedButtonOne({
    Key? key,
    this.prefixIcon,
    required this.buttonLabel,
    this.backgroundColor,
    this.foregroundColor,
    this.buttonClickAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        foregroundColor: WidgetStateProperty.all(foregroundColor),
        minimumSize: WidgetStateProperty.all(const Size(double.maxFinite, double.minPositive)),
        padding: WidgetStateProperty.all(const EdgeInsets.only(top: 14, bottom: 14)),
        side: WidgetStateProperty.all(
          BorderSide(
            color: AppColor().lightWhite,
            width: 1.5,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppText().inputBoxRadius), // Border radius
          ),
        ),
      ),
      onPressed: buttonClickAction,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: prefixIcon != null,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: SvgPicture.asset(
                prefixIcon!,
              ),
            ),
          ),
          Text(
            buttonLabel,
            style: TextStyle(
              fontSize: AppText().mediumFontSize,
              fontFamily: AppText().primaryFont,
            ),
          ),
        ],
      ),
    );
  }
}
