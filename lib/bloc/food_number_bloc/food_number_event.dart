part of 'food_number_bloc.dart';

@immutable
abstract class FoodNumberEvent {
  const FoodNumberEvent();
}

class FindFood extends FoodNumberEvent {
  final FoodCategory foodCategory;

  const FindFood({
    required this.foodCategory,
  });

  @override
  List<Object> get props => [foodCategory];

  FindFood copyWith({
    FoodCategory? foodCategory,
  }) {
    return FindFood(
      foodCategory: foodCategory ?? this.foodCategory,
    );
  }
}

class RemoveFood extends FoodNumberEvent {
  final FoodCategory foodCategory;

  const RemoveFood({
    required this.foodCategory,
  });

  @override
  List<Object> get props => [foodCategory];

  RemoveFood copyWith({
    FoodCategory? foodCategory,
  }) {
    return RemoveFood(
      foodCategory: foodCategory ?? this.foodCategory,
    );
  }
}

class RemoveTotalFood extends FoodNumberEvent {
  const RemoveTotalFood();
}

class RemoveALLFood extends FoodNumberEvent {
  const RemoveALLFood();
}