import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:testtesttest/bloc/food_number_bloc/food_number_bloc.dart';
import 'package:testtesttest/model/food_inventory_model.dart';
import 'package:testtesttest/view/flame_animation.dart';

class BakedGoodComponent extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlameAnimation> {
  final FoodNumberBloc foodNumberBloc;
  final String bakedGoodName;
  BakedGoodComponent({
    required Vector2 size,
    required this.foodNumberBloc,
    required this.bakedGoodName,
  }) {
    debugMode = true;
    add(RectangleHitbox.relative(Vector2.all(0.5), parentSize: size));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    for(var foodName in FoodCategory.values){
      if('FoodCategory.$bakedGoodName' == foodName.toString()) {
        foodNumberBloc.add(FindFood(foodCategory: foodName));
      }
    }
    gameRef.remove(this);
  }
}
