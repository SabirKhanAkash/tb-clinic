import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_clinic/data/dto/auth_dto.dart';
import 'package:tb_clinic/ui/shared/components/custom_button_one.dart';
import 'package:tb_clinic/ui/shared/components/custom_text_form_field_one.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_text.dart';
import 'package:tb_clinic/viewmodels/auth/cubit/auth_cubit.dart';
import 'package:tb_clinic/viewmodels/auth/state/auth_state.dart';

Widget buildBody(
  TextEditingController userNameController,
  TextEditingController passwordController,
) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                AppText().loginHeadingOne,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16, color: AppColor().borderColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Container(
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
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();
            return Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
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
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: CustomTextFormFieldOne(
                    controller: passwordController,
                    maxLines: 1,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: AppText().loginHintTwo,
                    obscureText: (state is AuthObscurePassword) ? state.isObscure : true,
                    suffixIconVisibility: true,
                    suffixIconAction: () => cubit.toggleObscureness(
                      (state is AuthObscurePassword) ? state.isObscure : true,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
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
            return state is AuthLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: AppColor().white,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColor().red),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomButtonOne(
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
                  );
          },
        )
      ],
    ),
  );
}
