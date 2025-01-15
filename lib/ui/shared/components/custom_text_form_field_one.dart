import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_image.dart';
import 'package:tb_clinic/utils/config/app_style.dart';

class CustomTextFormFieldOne extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLength;
  final int maxLines;
  final bool obscureText;
  final bool suffixIconVisibility;
  final bool prefixIconVisibility;
  final bool counterTextEnabled;
  final VoidCallback? suffixIconAction;
  final VoidCallback? prefixIconAction;

  const CustomTextFormFieldOne({
    super.key,
    required this.controller,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.maxLength = 50,
    this.maxLines = 1,
    this.obscureText = false,
    this.suffixIconVisibility = false,
    this.prefixIconVisibility = false,
    this.counterTextEnabled = false,
    this.suffixIconAction,
    this.prefixIconAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(height: 1.2, fontSize: AppStyle().regularDp, color: AppColor().gray),
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyle().smallDp),
          borderSide: BorderSide(
            color: AppColor().borderColor,
          ),
        ),
        hintText: hintText,
        prefixIcon: prefixIconVisibility
            ? IconButton(
                icon: SvgPicture.asset(
                  AppImage().searchIcon,
                  color: Colors.black,
                ),
                onPressed: suffixIconAction,
              )
            : null,
        suffixIcon: suffixIconVisibility
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: suffixIconAction,
              )
            : null,
        counterText: !counterTextEnabled ? "" : null,
      ),
    );
  }
}
