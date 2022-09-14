import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtesttest/bloc/food_number_bloc/food_number_bloc.dart';
import 'package:testtesttest/bloc/friend_number_bloc/friend_number_bloc.dart';
import 'package:testtesttest/controller/button_controller.dart';
import 'package:testtesttest/view/flame_animation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final friendNumberBloc = context.read<FriendNumberBloc>();
    final foodNumberBloc = context.read<FoodNumberBloc>();

    return GameWidget(
      game: FlameAnimation(
        friendNumberBloc: friendNumberBloc,
        foodNumberBloc: foodNumberBloc,
      ),
      overlayBuilderMap: {
        'ButtonController': (BuildContext context, FlameAnimation game) {
          return ButtonController(
            game: game,
          );
        },
      },
    );
  }
}
