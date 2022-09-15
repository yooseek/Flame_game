import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/widgets.dart';
import 'package:testtesttest/bloc/george_position_bloc/george_position_bloc.dart';
import 'package:testtesttest/my_game.dart';

class DialogBox extends TextBoxComponent{
  final MyGame game;
  final GeorgePositionBloc georgePositionBloc;

  DialogBox({
    required String text,
    required this.game,
    required this.georgePositionBloc,
  }) : super(
            text: text,
            position: georgePositionBloc.state.position,
            boxConfig: TextBoxConfig(
              timePerChar: 0.1,
              dismissDelay: 3.0,
              maxWidth: game.size.x * 0.5,
              margins: const EdgeInsets.all(8.0),
              growingBox: true,
            ),
            textRenderer: TextPaint(
              style: TextStyle(
                  fontSize: 18,
                  color: BasicPalette.white.color,
                wordSpacing: 100.0,
              ),
            )) {

    anchor = Anchor.bottomRight;
  }

  @override
  void drawBackground(Canvas c) {
    RRect rRect =
        RRect.fromLTRBR(0, 0, width, height, const Radius.circular(0.5));
    Rect rect = Rect.fromLTRB(0, 0, width, height);
    // c.drawRRect(
    //   rRect,
    //   Paint()..color = const Color(0x8f37474f),
    // );
    c.drawRect(
      rect,
      Paint()..color = const Color(0x8f37474f),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (finished) {
      removeFromParent();
    }
  }
}
