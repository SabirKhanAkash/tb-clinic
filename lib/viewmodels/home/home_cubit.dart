import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_clinic/viewmodels/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void selectBottomNavItem(int currentItemIndex) {
    emit(BottomNavBarItemSelection(currentItemIndex));
  }
}
