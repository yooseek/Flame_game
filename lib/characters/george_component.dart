import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/game.dart';
import 'package:testtesttest/bloc/noti_overlay_bloc/noti_overlay_bloc.dart';
import 'package:testtesttest/my_game.dart';

class GeorgeComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  final MyGame game;
  final NotiOverlayBloc notiOverlayBloc;

  SpriteAnimation get initAnimation => idleAnimation;

  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation idleAnimation;

  final double animationSpeed = 0.1;

  GeorgeComponent({
    required this.game,
    required Vector2 size,
    required this.notiOverlayBloc,
  }) {
    add(RectangleHitbox.relative(Vector2.all(0.5), parentSize: size));
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 조지 (인물)
    final spriteSheet = SpriteSheet(
        image: await gameRef.images.load('george.png'),
        srcSize: Vector2(48, 48));

    downAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: animationSpeed, to: 4);
    leftAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: animationSpeed, to: 4);
    upAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: animationSpeed, to: 4);
    rightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: animationSpeed, to: 4);
    idleAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: animationSpeed, to: 1);

    animation = idleAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!notiOverlayBloc.state.showNoti) {
      // 움직임 애니메이션 적용
      switch (game.direction) {
        case 0:
          animation = idleAnimation;
          break;
        case 1:
          animation = downAnimation;
          if (y < game.mapHeight - height) {
            if (game.collisionDirection != 1) {
              y += dt * game.characterSpeed;
            }
          }
          break;
        case 2:
          animation = leftAnimation;
          if (x > 0) {
            if (game.collisionDirection != 2) {
              x -= dt * game.characterSpeed;
            }
          }
          break;
        case 3:
          animation = upAnimation;
          if (y > 0) {
            if (game.collisionDirection != 3) {
              y -= dt * game.characterSpeed;
            }
          }
          break;
        case 4:
          animation = rightAnimation;
          if (x < game.mapWidth - width) {
            if (game.collisionDirection != 4) {
              x += dt * game.characterSpeed;
            }
          }
          break;
      }
    }
  }
}
