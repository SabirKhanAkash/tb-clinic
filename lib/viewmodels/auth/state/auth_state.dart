import 'package:tb_clinic/data/models/data_model/data.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthObscurePassword extends AuthState {
  final bool isObscure;

  AuthObscurePassword(this.isObscure);
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
