import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_clinic/viewmodels/location/location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  void selectLocationType(String selectedType) {
    emit(LocationTypeSelection(selectedType));
  }
}
