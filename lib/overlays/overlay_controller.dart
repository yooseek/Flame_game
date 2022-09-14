import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtesttest/bloc/food_number_bloc/food_number_bloc.dart';
import 'package:testtesttest/bloc/friend_number_bloc/friend_number_bloc.dart';
import 'package:testtesttest/model/food_inventory_model.dart';
import 'package:testtesttest/my_game.dart';
import 'package:testtesttest/overlays/dialog_overlay.dart';

class OverlayController extends StatelessWidget {
  final MyGame game;

  const OverlayController({
    required this.game,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final friendNum = context.watch<FriendNumberBloc>().state.findFriendNumber;
    final foodInventoryState = context.watch<FoodNumberBloc>().state;

    final int totalFoodNum =
        foodInventoryState.foodInventory.fold(0, (p, e) => p + e.count);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AudioOverlay(game: game),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ScoreOverlay(friendNum: friendNum, totalFoodNum: totalFoodNum),
              Expanded(child: DialogOverlay(game: game),),
            ],
          ),
        ),
      ],
    );
  }
}

class ScoreOverlay extends StatelessWidget {
  const ScoreOverlay({
    Key? key,
    required this.friendNum,
    required this.totalFoodNum,
  }) : super(key: key);

  final int friendNum;
  final int totalFoodNum;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/Amelia.png',
          scale: 0.7,
        ),
        const SizedBox(
          width: 14.0,
        ),
        Text(
          '$friendNum',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 21.0,
            color: Colors.black54,
          ),
        ),
        const SizedBox(
          width: 14.0,
        ),
        Image.asset(
          'assets/images/bread.png',
          scale: 0.7,
        ),
        const SizedBox(
          width: 14.0,
        ),
        Text(
          '$totalFoodNum',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 21.0,
            color: Colors.black54,
          ),
        )
      ],
    );
  }
}

class AudioOverlay extends StatelessWidget {
  const AudioOverlay({
    Key? key,
    required this.game,
  }) : super(key: key);

  final MyGame game;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: const Color(0x8f37474f),
          child: IconButton(
            onPressed: () {
              print('press volume up');
              FlameAudio.bgm.play('sfx/ukulele.mp3');
            },
            icon: const Icon(Icons.volume_up_rounded),
            color: Colors.pink.shade200,
          ),
        ),
        Container(
          color: const Color(0x8f37474f),
          child: IconButton(
            onPressed: () {
              print('press volume stop');
              FlameAudio.bgm.stop();
            },
            icon: const Icon(Icons.volume_off_rounded),
            color: Colors.pink.shade200,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          game.soundTrackName,
          style: TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeight.w500,
            color: Colors.pink.shade200,
          ),
        ),
      ],
    );
  }
}
