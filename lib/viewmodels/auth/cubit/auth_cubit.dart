import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_clinic/data/dto/auth_dto.dart';
import 'package:tb_clinic/data/models/data_model/data.dart';
import 'package:tb_clinic/data/repositories/remote/auth_repository.dart';
import 'package:tb_clinic/viewmodels/auth/state/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  void toggleObscureness(bool isObscure) {
    emit(AuthObscurePassword(isObscure));
  }

  Future<void> login(AuthDto authDto) async {
    emit(AuthLoading(true));
    try {
      Data? loginResponse =
          await _authRepository.login({'username': authDto.username, 'password': authDto.password});
      emit(AuthSuccess(loginResponse));
    } catch (e) {
      emit(AuthLoading(false));
      emit(AuthFailure(e.toString()));
    }
  }
}
