import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_clinic/data/dto/auth_dto.dart';
import 'package:tb_clinic/viewmodels/auth/cubit/auth_cubit.dart';
import 'package:tb_clinic/viewmodels/auth/state/auth_state.dart';

Widget buildBody(
    TextEditingController userNameController, TextEditingController passwordController) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
              controller: userNameController,
              textAlign: TextAlign.start,
              maxLines: 1,
              maxLength: 20,
              keyboardType: TextInputType.name),
        ),
        const SizedBox(height: 20),
        BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: passwordController,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  maxLength: 20,
                  keyboardType: TextInputType.name,
                  obscureText: state is AuthObscurePassword ? state.isObscure : true,
                ),
              );
            }),
        const SizedBox(height: 20),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error.toString())));
            }
          },
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();
            return state is AuthLoading
                ? const CircularProgressIndicator.adaptive()
                : ElevatedButton(
                    onLongPress: () => (state is AuthObscurePassword)
                        ? cubit.toggleObscureness(state.isObscure)
                        : (),
                    onPressed: () async => await cubit.login(AuthDto(
                        username: userNameController.text, password: passwordController.text)),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontFamily: 'inter'),
                    ),
                  );
          },
        )
      ],
    ),
  );
}
