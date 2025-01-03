abstract class HomeState {}

class HomeInitial extends HomeState {}

class BottomNavBarItemSelection extends HomeState {
  final int currentItemIndex;

  BottomNavBarItemSelection(this.currentItemIndex);
}
