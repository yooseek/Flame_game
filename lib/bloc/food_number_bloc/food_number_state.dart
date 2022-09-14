part of 'food_number_bloc.dart';

enum FoodState {
  init,
  normal,
  empty,
  full,
}

class FoodNumberState {
  final List<FoodInventory> foodInventory;
  final FoodState foodState;

  const FoodNumberState({
    required this.foodInventory,
    required this.foodState,
  });

  factory FoodNumberState.initial() {
    return const FoodNumberState(foodInventory: [],foodState: FoodState.init);
  }

  @override
  List<Object?> get props => [foodInventory, foodState];

  FoodNumberState copyWith({
    List<FoodInventory>? foodInventory,
    FoodState? foodState,
  }) {
    return FoodNumberState(
      foodInventory: foodInventory ?? this.foodInventory,
      foodState: foodState ?? this.foodState,
    );
  }
}