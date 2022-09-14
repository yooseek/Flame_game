import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:testtesttest/bloc/food_number_bloc/food_number_bloc.dart';
import 'package:testtesttest/bloc/friend_number_bloc/friend_number_bloc.dart';
import 'package:testtesttest/bloc/george_position_bloc/george_position_bloc.dart';
import 'package:testtesttest/characters/friend_component.dart';
import 'package:testtesttest/my_game.dart';
import 'package:tiled/tiled.dart';

void loadFriends({
  required FriendNumberBloc friendNumberBloc,
  required FoodNumberBloc foodNumberBloc,
  required GeorgePositionBloc georgePositionBloc,
  required TiledComponent homeMap,
  required MyGame game,
}) {
  // 버전업
  // getObjectGroupFromLayer('freinds') => getLayer('friends');
  final friendGroup = homeMap.tileMap.getLayer<ObjectGroup>('friends');

  for (var friendBox in friendGroup!.objects) {
    final friend = FriendComponent(
      game: game,
      friendNumberBloc: friendNumberBloc,
      foodNumberBloc: foodNumberBloc,
      georgePositionBloc: georgePositionBloc,
    )
      ..position = Vector2(friendBox.x, friendBox.y)
      ..width = friendBox.width
      ..height = friendBox.height
      ..debugMode = true;

    print('친구가 생성되었습니다 ${friendBox.id}');
    game.componentList.add(friend);
    friendNumberBloc.add(AddFriend(id: friendBox.id));
    game.add(friend);
  }
}
