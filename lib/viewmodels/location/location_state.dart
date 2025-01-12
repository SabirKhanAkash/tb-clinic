abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationTypeSelection extends LocationState {
  final String selectedType;

  LocationTypeSelection(this.selectedType);
}
