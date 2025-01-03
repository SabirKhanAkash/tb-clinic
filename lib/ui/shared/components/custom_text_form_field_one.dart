import 'package:flutter/material.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_style.dart';

class CustomTextFormFieldOne extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLength;
  final int maxLines;
  final bool obscureText;
  final bool suffixIconVisibility;
  final bool counterTextEnabled;
  final VoidCallback? suffixIconAction;

  const CustomTextFormFieldOne({
    super.key,
    required this.controller,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.maxLength = 50,
    this.maxLines = 1,
    this.obscureText = false,
    this.suffixIconVisibility = false,
    this.counterTextEnabled = false,
    this.suffixIconAction,
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
        suffixIcon: Visibility(
          visible: suffixIconVisibility,
          child: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: suffixIconAction,
          ),
        ),
        counterText: !counterTextEnabled ? "" : null,
      ),
    );
  }
}
