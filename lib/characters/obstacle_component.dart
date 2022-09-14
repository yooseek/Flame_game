import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:testtesttest/bloc/food_number_bloc/food_number_bloc.dart';
import 'package:testtesttest/bloc/friend_number_bloc/friend_number_bloc.dart';
import 'package:testtesttest/characters/george_component.dart';
import 'package:testtesttest/dialog/dialog_box.dart';
import 'package:testtesttest/model/food_inventory_model.dart';
import 'package:testtesttest/my_game.dart';

// 버전업
// HasHitboxes, Collidable => CollisionCallbacks
class ObstacleComponent extends PositionComponent with CollisionCallbacks {
  final MyGame game;
  final FriendNumberBloc friendNumberBloc;
  final FoodNumberBloc foodNumberBloc;

  bool _hasCollided = false;

  ObstacleComponent({
    required this.game,
    required this.friendNumberBloc,
    required this.foodNumberBloc,
  }) {
    // addHitbox(HitRectangle())  => add(RectangleHitbox());
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) async {
    super.onCollision(intersectionPoints, other);

    // other에 부딧히는 타겟이 들어온다
    if(other is GeorgeComponent) {
      if(!_hasCollided){
        game.collisionDirection = game.direction;
        _hasCollided = true;
      }

    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if(other is GeorgeComponent) {
      game.collisionDirection = -1;
      _hasCollided = false;
    }
  }
}
