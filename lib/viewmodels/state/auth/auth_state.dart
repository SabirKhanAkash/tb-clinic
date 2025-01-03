import 'package:tb_clinic/data/models/data_model/data.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginObscurePassword extends AuthState {
  final bool isObscure;

  LoginObscurePassword(this.isObscure);
}

class RegisterObscurePassword extends AuthState {
  final bool isObscure;

  RegisterObscurePassword(this.isObscure);
}

class RegisterObscureConfirmPassword extends AuthState {
  final bool isObscure;

  RegisterObscureConfirmPassword(this.isObscure);
}

class AuthCheckRememberMe extends AuthState {
  final bool isChecked;

  AuthCheckRememberMe(this.isChecked);
}

class AuthLoading extends AuthState {
  final bool isLoading;

  AuthLoading(this.isLoading);
}

class AuthSuccess extends AuthState {
  final Data? data;

  AuthSuccess(this.data);
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}
