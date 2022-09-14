enum FoodCategory {
  bread,
  burger,
  apple_pie,
}

class FoodInventory {
  FoodCategory foodCategory;
  int count;

  FoodInventory({
    required this.foodCategory,
    required this.count,
  });

  @override
  List<Object> get props => [];

  FoodInventory copyWith({
    FoodCategory? foodCategory,
    int? count,
  }) {
    return FoodInventory(
      foodCategory: foodCategory ?? this.foodCategory,
      count: count ?? this.count,
    );
  }
}