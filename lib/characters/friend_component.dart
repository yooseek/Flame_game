import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:testtesttest/bloc/food_number_bloc/food_number_bloc.dart';
import 'package:testtesttest/bloc/friend_number_bloc/friend_number_bloc.dart';
import 'package:testtesttest/bloc/george_position_bloc/george_position_bloc.dart';
import 'package:testtesttest/characters/george_component.dart';
import 'package:testtesttest/dialog/dialog_box.dart';
import 'package:testtesttest/model/food_inventory_model.dart';
import 'package:testtesttest/my_game.dart';

// 버전업
// HasHitboxes, Collidable => CollisionCallbacks
class FriendComponent extends PositionComponent with CollisionCallbacks{
  final MyGame game;
  final FriendNumberBloc friendNumberBloc;
  final FoodNumberBloc foodNumberBloc;
  final GeorgePositionBloc georgePositionBloc;

  FriendComponent({
    required this.game,
    required this.friendNumberBloc,
    required this.foodNumberBloc,
    required this.georgePositionBloc,
  }) {
    // addHitbox(HitRectangle())  => add(RectangleHitbox());
    add(RectangleHitbox());
  }

  @override
  void onCollision(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (other is GeorgeComponent) {
      String message = '';

      if (foodNumberBloc.state.foodState != FoodState.init &&
          foodNumberBloc.state.foodState != FoodState.empty) {
        message = '맛있는 음식 고마워!';

        // 친구 + 음식 -
        friendNumberBloc.add(FindFriend());
        foodNumberBloc.add(const RemoveTotalFood());

        // 효과음
        game.applause.start();

        // 대화창 출력
        game.dialogBox = DialogBox(
            game: game, text: message, georgePositionBloc: georgePositionBloc);
        game.add(game.dialogBox);

        // 한번만 되게
        removeFromParent();
        game.componentList.removeWhere((element) => element == this);

        await checkNewScene();
      } else {
        message = '배고파요 ㅠ '
            '음식이 필요해요! ';
        // 대화창 출력
        game.dialogBox = DialogBox(
            game: game, text: message, georgePositionBloc: georgePositionBloc);
        game.add(game.dialogBox);

        return;
      }
    }

    super.onCollision(intersectionPoints, other);
  }

  Future<void> checkNewScene() async {
    if (friendNumberBloc.state.findFriendNumber+1 ==
        friendNumberBloc.state.maxFriendNumber.length) {
      game.sceneNumber++;
      game.newScene();
    }
    print('총 인원 : ${friendNumberBloc.state.maxFriendNumber}');
    print('찾은 인원 : ${friendNumberBloc.state.findFriendNumber}');
  }
}
