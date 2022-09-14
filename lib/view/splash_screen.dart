import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtesttest/bloc/food_number_bloc/food_number_bloc.dart';
import 'package:testtesttest/bloc/friend_number_bloc/friend_number_bloc.dart';
import 'package:testtesttest/bloc/george_position_bloc/george_position_bloc.dart';
import 'package:testtesttest/bloc/noti_overlay_bloc/noti_overlay_bloc.dart';
import 'package:testtesttest/my_game.dart';
import 'package:testtesttest/overlays/overlay_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final friendNumberBloc = context.read<FriendNumberBloc>();
    final foodNumberBloc = context.read<FoodNumberBloc>();
    final georgePositionBloc = context.read<GeorgePositionBloc>();
    final notiOverlayBloc = context.read<NotiOverlayBloc>();

    return Center(
      child: GameWidget(
        game: MyGame(
          friendNumberBloc: friendNumberBloc,
          foodNumberBloc: foodNumberBloc,
          georgePositionBloc: georgePositionBloc,
            notiOverlayBloc:notiOverlayBloc,
        ),
        overlayBuilderMap: {
          'OverlayController': (BuildContext context, MyGame game) {
            return OverlayController(
              game: game,
            );
          },
        },
      ),
    );
  }
}
