import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtesttest/bloc/noti_overlay_bloc/noti_overlay_bloc.dart';
import 'package:testtesttest/my_game.dart';

class DialogOverlay extends StatelessWidget {
  final MyGame game;
  const DialogOverlay({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notiState = context.watch<NotiOverlayBloc>().state;

    return notiState.showNoti ? Container(
      color: const Color.fromARGB(167,218,218,218),
      child: AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText(
            notiState.message,
            textStyle: const TextStyle(
              fontSize: 18.0,
              color: Colors.black
            ),
            speed: const Duration(milliseconds: 100),
          ),
        ],
        isRepeatingAnimation: false,
        onFinished: () {
          context.read<NotiOverlayBloc>().add(EndNotiOverlay());
        },
      ),
    ) : Container();
  }
}
