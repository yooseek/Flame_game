import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:testtesttest/bloc/friend_number_bloc/friend_number_bloc.dart';
import 'package:testtesttest/view/flame_animation.dart';

// 버전업
// HasHitboxes, Collidable => CollisionCallbacks
class FriendComponent extends PositionComponent with CollisionCallbacks{
  final FlameAnimation game;
  final FriendNumberBloc friendNumberBloc;

  FriendComponent({required this.game,required this.friendNumberBloc,}) {
    // addHitbox(HitRectangle())  => add(RectangleHitbox());
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints ,PositionComponent other) {
    print('I made a new friend!');

    friendNumberBloc.add(FindFriend());

    // 한번만 되게
    removeFromParent();
    super.onCollision(intersectionPoints, other);
  }
}