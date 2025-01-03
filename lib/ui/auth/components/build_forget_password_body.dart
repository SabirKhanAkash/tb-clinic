import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_clinic/ui/shared/components/custom_elevated_button_one.dart';
import 'package:tb_clinic/ui/shared/components/custom_text_form_field_one.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_image.dart';
import 'package:tb_clinic/utils/config/app_style.dart';
import 'package:tb_clinic/utils/config/app_text.dart';
import 'package:tb_clinic/viewmodels/auth/auth_cubit.dart';
import 'package:tb_clinic/viewmodels/auth/auth_state.dart';

Widget buildForgetPasswordBody(
  TextEditingController emailController,
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
                  AppText().registerHeadingThree,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16, color: AppColor().borderColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 25),
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
                              buttonLabel: AppText().forgetPasswordButtonText,
                              backgroundColor: AppColor().red,
                              foregroundColor: AppColor().white,
                              buttonClickAction: () =>
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text("A confirmation email has been sent. "
                                          "Check your email"))),
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
                            AppText().gotoLoginButtonTextTwo,
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
