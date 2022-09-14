import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtesttest/bloc/food_number_bloc/food_number_bloc.dart';
import 'package:testtesttest/bloc/friend_number_bloc/friend_number_bloc.dart';
import 'package:testtesttest/model/food_inventory_model.dart';
import 'package:testtesttest/view/flame_animation.dart';

class ButtonController extends StatelessWidget {
  final FlameAnimation game;

  const ButtonController({
    required this.game,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final friendNum = context.watch<FriendNumberBloc>().state.findFriendNumber;
    final foodInventoryState = context.watch<FoodNumberBloc>().state;

    final int totalFoodNum = foodInventoryState.foodInventory.fold(0, (p, e) => p + e.count);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              color: const Color(0x8f37474f),
              child: IconButton(
                onPressed: () {
                  print('press volume up');
                  FlameAudio.bgm.play('ukulele.mp3');
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
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
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
          ),
        ),
      ],
    );
  }
}
