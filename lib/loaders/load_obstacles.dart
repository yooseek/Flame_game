import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';
import 'package:testtesttest/bloc/food_number_bloc/food_number_bloc.dart';
import 'package:testtesttest/bloc/friend_number_bloc/friend_number_bloc.dart';
import 'package:testtesttest/characters/obstacle_component.dart';
import 'package:testtesttest/my_game.dart';
import 'package:tiled/tiled.dart';

void loadObstacles({
  required FriendNumberBloc friendNumberBloc,
  required FoodNumberBloc foodNumberBloc,
  required TiledComponent homeMap,
  required MyGame game,
}) {
  // 버전업
  // getObjectGroupFromLayer('freinds') => getLayer('obstacles');
  final obstacleGroup = homeMap.tileMap.getLayer<ObjectGroup>('obstacles');

  for (var obstacleBox in obstacleGroup!.objects) {
    final obstacle = ObstacleComponent(
      game: game,
      friendNumberBloc: friendNumberBloc,
      foodNumberBloc: foodNumberBloc,
    )
      ..position = Vector2(obstacleBox.x, obstacleBox.y)
      ..width = obstacleBox.width
      ..height = obstacleBox.height
      ..debugMode = kReleaseMode ? false : true;

    game.componentList.add(obstacle);
    game.add(obstacle);
  }
}
