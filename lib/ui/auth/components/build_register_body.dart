import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_clinic/data/dto/auth_dto.dart';
import 'package:tb_clinic/ui/shared/components/custom_elevated_button_one.dart';
import 'package:tb_clinic/ui/shared/components/custom_text_form_field_one.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_image.dart';
import 'package:tb_clinic/utils/config/app_style.dart';
import 'package:tb_clinic/utils/config/app_text.dart';
import 'package:tb_clinic/viewmodels/cubit/auth/auth_cubit.dart';
import 'package:tb_clinic/viewmodels/state/auth/auth_state.dart';

Widget buildRegisterBody(
  TextEditingController firstNameController,
  TextEditingController lastNameController,
  TextEditingController emailController,
  TextEditingController passwordController,
  TextEditingController confirmPasswordController,
) {
  return SafeArea(
    child: Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImage().logoWithTagForRegisterScreen,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  AppText().registerHeadingOne,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16, color: AppColor().borderColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: CustomTextFormFieldOne(
                controller: firstNameController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                hintText: AppText().registerHintOne,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  AppText().registerHeadingTwo,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16, color: AppColor().borderColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: CustomTextFormFieldOne(
                controller: lastNameController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                hintText: AppText().registerHintTwo,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  AppText().registerHeadingThree,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16, color: AppColor().borderColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: CustomTextFormFieldOne(
                controller: emailController,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                hintText: AppText().registerHintThree,
              ),
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.data?.message ?? "Successfully Logged in")));
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: SelectableText(
                          state.error.toString().contains(AppText().exceptionHeading)
                              ? state.error.toString().split(AppText().exceptionHeading)[1]
                              : state.error.toString())));
                }
              },
              builder: (context, state) {
                final cubit = context.read<AuthCubit>();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
                        child: Text(
                          AppText().registerHeadingFour,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor().borderColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: CustomTextFormFieldOne(
                        controller: passwordController,
                        maxLines: 1,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: AppText().registerHintFour,
                        obscureText: (state is RegisterObscurePassword) ? state.isObscure : true,
                        suffixIconVisibility: true,
                        suffixIconAction: () => cubit.toggleObscureness(
                            (state is RegisterObscurePassword) ? state.isObscure : true,
                            "register"),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
                        child: Text(
                          AppText().registerHeadingFive,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor().borderColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 25),
                      child: CustomTextFormFieldOne(
                        controller: confirmPasswordController,
                        maxLines: 1,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: AppText().registerHintFive,
                        obscureText:
                            (state is RegisterObscureConfirmPassword) ? state.isObscure : true,
                        suffixIconVisibility: true,
                        suffixIconAction: () => cubit.toggleObscureness(
                            (state is RegisterObscureConfirmPassword) ? state.isObscure : true,
                            "registerConfirm"),
                      ),
                    ),
                    state is AuthLoading
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: AppColor().white,
                                valueColor: AlwaysStoppedAnimation<Color>(AppColor().red),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: CustomElevatedButtonOne(
                              buttonLabel: AppText().registerButtonText,
                              backgroundColor: AppColor().red,
                              foregroundColor: AppColor().white,
                              buttonClickAction: () async => await cubit.login(
                                AuthDto(
                                  email: firstNameController.text,
                                  password: passwordController.text,
                                ),
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              height: 1,
                              color: AppColor().veryLightGray,
                              indent: 15,
                              endIndent: 15,
                            ),
                          ),
                          Text(
                            AppText().or,
                            style: TextStyle(fontSize: AppStyle().mediumDp),
                          ),
                          Expanded(
                            child: Divider(
                              height: 1,
                              color: AppColor().veryLightGray,
                              indent: 15,
                              endIndent: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            AppText().gotoLoginButtonText,
                            style: TextStyle(
                              fontSize: AppStyle().regularDp,
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              AppText().loginButton,
                              style: TextStyle(
                                color: AppColor().red,
                                fontWeight: FontWeight.bold,
                                fontSize: AppStyle().regularDp,
                              ),
                            ),
                            onTap: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
