import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame/extensions.dart';
import 'package:testtesttest/bloc/food_number_bloc/food_number_bloc.dart';
import 'package:testtesttest/bloc/friend_number_bloc/friend_number_bloc.dart';
import 'package:testtesttest/characters/friend_component.dart';
import 'package:testtesttest/characters/george_component.dart';
import 'package:testtesttest/loaders/add_baked_goods.dart';
import 'package:tiled/tiled.dart';

// HasCollidables => HasCollisionDetection
class FlameAnimation extends FlameGame with HasCollisionDetection, TapDetector {
  final FriendNumberBloc friendNumberBloc;
  final FoodNumberBloc foodNumberBloc;
  FlameAnimation({required this.friendNumberBloc,required this.foodNumberBloc,});

  late SpriteAnimationComponent girl;

  // late SpriteComponent background;

  late GeorgeComponent george;
  late double mapWidth;
  late double mapHeight;

  // 0 = idle , 1 = down, 2 = left, 3 = up, 4 = right
  int direction = 0;
  final double characterSize = 100;
  final double characterSpeed = 80;
  String soundTrackName = 'ukulele';
  int bakedGoodsInventory = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 배경
    // 각각의 타일은 16 px이다.
    final homeMap = await TiledComponent.load('map.tmx', Vector2.all(16));
    add(homeMap);

    // 오버레이
    overlays.add('ButtonController');

    mapWidth = homeMap.tileMap.map.width * 16.0;
    mapHeight = homeMap.tileMap.map.height * 16.0;

    addBakedGoods(homeMap,this);

    // 버전업
    // getObjectGroupFromLayer('freinds') => getLayer('friends');
    final friendGroup = homeMap.tileMap.getLayer<ObjectGroup>('friends');

    for (var friendBox in friendGroup!.objects) {
      add(FriendComponent(game: this, friendNumberBloc: friendNumberBloc)
        ..position = Vector2(friendBox.x, friendBox.y)
        ..width = friendBox.width
        ..height = friendBox.height
        ..debugMode = true);
    }

    // 배경
    // Sprite backgroundSprite = await loadSprite('village.gif');
    // background = SpriteComponent()
    //   ..sprite = backgroundSprite
    //   ..size = backgroundSprite.originalSize;

    //add(background);

    // 음악
    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load('ukulele.mp3');

    george = GeorgeComponent(game: this,size: Vector2.all(characterSize))
      ..position = Vector2(200, size[0])
      ..debugMode = true
      ..size = Vector2.all(characterSize);

    // background = SpriteComponent()
    //   ..sprite = await loadSprite('castle.jpg')
    //   ..size = size;
    //
    // add(background);
    //
    // final sprites = await fromJSONAtlas('test.png', 'json/test.json');
    // SpriteAnimation walk = SpriteAnimation.spriteList(sprites, stepTime: 0.1);
    // girl = SpriteAnimationComponent()
    //   ..animation = walk
    //   ..position = Vector2(100, 100)
    //   ..size = Vector2(55, 55);
    //
    // add(girl);
    add(george);

    // 카메라 이동
    camera.followComponent(george,
        worldBounds: Rect.fromLTRB(0, 0, mapWidth, mapHeight));
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onTapUp(TapUpInfo info) {
    print('change animation');
    direction += 1;
    if (direction > 4) {
      direction = 0;
    }
  }
}
