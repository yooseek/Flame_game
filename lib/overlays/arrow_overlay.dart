import 'package:flutter/material.dart';
import 'package:testtesttest/my_game.dart';

class ArrowOverlay extends StatelessWidget {
  final MyGame game;
  const ArrowOverlay({required this.game,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ArrowKey(
          icons: Icons.keyboard_arrow_up,
          onTapDown: (det) {
            game.direction = 3;
          },
          onTapUp: (det) {
            game.direction = 0;
          },
          onLongPressDown: () {
            game.direction = 3;
          },
          onLongPressEnd: (dets) {
            game.direction = 0;
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ArrowKey(
              icons: Icons.keyboard_arrow_left,
              onTapDown: (det) {
                game.direction = 2;
              },
              onTapUp: (dets) {
                game.direction = 0;
              },
              onLongPressDown: () {
                game.direction = 2;
              },
              onLongPressEnd: (dets) {
                game.direction = 0;
              },
            ),
            ArrowKey(
              icons: Icons.keyboard_arrow_down,
              onTapDown: (det) {
                game.direction = 1;
              },
              onTapUp: (dets) {
                game.direction = 0;
              },
              onLongPressDown: () {
                game.direction = 1;
              },
              onLongPressEnd: (dets) {
                game.direction = 0;
              },
            ),
            ArrowKey(
              icons: Icons.keyboard_arrow_right,
              onTapDown: (det) {
                game.direction = 4;
              },
              onTapUp: (det) {
                game.direction = 0;
              },
              onLongPressDown: () {
                game.direction = 4;
              },
              onLongPressEnd: (dets) {
                game.direction = 0;
              },
            ),
          ],
        ),

      ],
    );
  }
}

class ArrowKey extends StatelessWidget {
  const ArrowKey({
    Key? key,
    required this.icons,
    required this.onTapDown,
    required this.onTapUp,
    required this.onLongPressDown,
    required this.onLongPressEnd,
  }) : super(key: key);
  final IconData icons;
  final Function(TapDownDetails) onTapDown;
  final Function(TapUpDetails) onTapUp;
  final Function() onLongPressDown;
  final Function(LongPressEndDetails) onLongPressEnd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onLongPress: onLongPressDown,
      onLongPressEnd: onLongPressEnd,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0x88ffffff),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Icon(
          icons,
          size: 42,
        ),
      ),
    );
  }
}
