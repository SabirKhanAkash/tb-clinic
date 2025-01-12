import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:tb_clinic/utils/helpers/map_helper.dart';
import 'package:tb_clinic/viewmodels/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void selectBottomNavItem(int currentItemIndex) {
    emit(BottomNavBarItemSelection(currentItemIndex));
  }

  void getMyCurrentLocation(BuildContext context) async {
    final result = await MapHelper().getMyLocation();
    late LatLng currentLatLng;

    result.fold(
        (ifLeft) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ifLeft))),
        (ifRight) => currentLatLng = ifRight);
    emit(MyCurrentLocation(currentLatLng));
  }
}
