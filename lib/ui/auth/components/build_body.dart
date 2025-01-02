import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_clinic/data/dto/auth_dto.dart';
import 'package:tb_clinic/ui/shared/components/custom_elevated_button_one.dart';
import 'package:tb_clinic/ui/shared/components/custom_outlined_button_one.dart';
import 'package:tb_clinic/ui/shared/components/custom_text_form_field_one.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_image.dart';
import 'package:tb_clinic/utils/config/app_text.dart';
import 'package:tb_clinic/viewmodels/auth/cubit/auth_cubit.dart';
import 'package:tb_clinic/viewmodels/auth/state/auth_state.dart';

Widget buildBody(
  TextEditingController userNameController,
  TextEditingController passwordController,
) {
  return SafeArea(
    child: Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImage().logoWithTag,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  AppText().loginHeadingOne,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16, color: AppColor().borderColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: CustomTextFormFieldOne(
                controller: userNameController,
                maxLines: 1,
                keyboardType: TextInputType.phone,
                maxLength: 15,
                hintText: AppText().loginHintOne,
              ),
            ),
            // const SizedBox(height: 20),
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
                final isCheckedRememberMe =
                    (state is AuthCheckRememberMe) ? state.isChecked : false;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
                        child: Text(
                          AppText().loginHeadingTwo,
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
                        hintText: AppText().loginHintTwo,
                        obscureText: (state is AuthObscurePassword) ? state.isObscure : false,
                        suffixIconVisibility: true,
                        suffixIconAction: () => cubit.toggleObscureness(
                          (state is AuthObscurePassword) ? state.isObscure : true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Checkbox(
                                value: isCheckedRememberMe,
                                onChanged: (bool? value) =>
                                    context.read<AuthCubit>().toggleCheckRememberMe(!value!),
                                fillColor: WidgetStateProperty.resolveWith((states) {
                                  if (states.contains(WidgetState.selected)) {
                                    return AppColor().purple;
                                  }
                                  return AppColor().white;
                                }),
                                checkColor: Colors.white,
                                side: WidgetStateBorderSide.resolveWith((states) {
                                  if (states.contains(WidgetState.selected)) {
                                    return BorderSide(color: AppColor().purple);
                                  }
                                  return BorderSide(color: AppColor().lightGray);
                                }),
                              ),
                              Text(
                                AppText().rememberMe,
                                style: TextStyle(
                                  color: AppColor().lightBlack,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Text(
                              AppText().forgotPassword,
                              style: TextStyle(
                                color: AppColor().red,
                                fontWeight: FontWeight.bold,
                                fontSize: AppText().inputBoxRadius,
                              ),
                            ),
                          )
                        ],
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
                              buttonLabel: AppText().loginButtonText,
                              backgroundColor: AppColor().red,
                              foregroundColor: AppColor().white,
                              buttonClickAction: () async => await cubit.login(
                                AuthDto(
                                  username: userNameController.text,
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
                            style: TextStyle(fontSize: AppText().mediumFontSize),
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
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                      child: CustomOutLinedButtonOne(
                        buttonLabel: AppText().loginWithGoogleButtonText,
                        backgroundColor: AppColor().white,
                        foregroundColor: AppColor().black,
                        buttonClickAction: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Coming soon...")),
                        ),
                        prefixIcon: AppImage().googleIcon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                      child: CustomOutLinedButtonOne(
                        buttonLabel: AppText().loginWithFacebookButtonText,
                        backgroundColor: AppColor().white,
                        foregroundColor: AppColor().black,
                        buttonClickAction: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Coming soon...")),
                        ),
                        prefixIcon: AppImage().facebookIcon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            AppText().gotoSignUpButtonText,
                            style: TextStyle(
                              fontSize: AppText().regularFontSize,
                            ),
                          ),
                          Text(
                            AppText().registerButton,
                            style: TextStyle(
                              color: AppColor().red,
                              fontWeight: FontWeight.bold,
                              fontSize: AppText().regularFontSize,
                            ),
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
