import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:testtesttest/bloc/food_number_bloc/food_number_bloc.dart';
import 'package:testtesttest/bloc/friend_number_bloc/friend_number_bloc.dart';
import 'package:testtesttest/bloc/george_position_bloc/george_position_bloc.dart';
import 'package:testtesttest/bloc/noti_overlay_bloc/noti_overlay_bloc.dart';
import 'package:testtesttest/characters/george_component.dart';
import 'package:testtesttest/dialog/dialog_box.dart';
import 'package:testtesttest/loaders/add_baked_goods.dart';
import 'package:testtesttest/loaders/load_friends.dart';
import 'package:testtesttest/loaders/load_obstacles.dart';

// HasCollidables => HasCollisionDetection
class MyGame extends FlameGame with HasCollisionDetection, TapDetector {
  final FriendNumberBloc friendNumberBloc;
  final FoodNumberBloc foodNumberBloc;
  final GeorgePositionBloc georgePositionBloc;
  final NotiOverlayBloc notiOverlayBloc;
  MyGame({
    required this.friendNumberBloc,
    required this.foodNumberBloc,
    required this.georgePositionBloc,
    required this.notiOverlayBloc,
  });
  late GeorgeComponent george;
  late double mapWidth;
  late double mapHeight;
  late TiledComponent homeMap;
  List<Component> componentList = [];
  int sceneNumber = 1;

  // 0 = idle , 1 = down, 2 = left, 3 = up, 4 = right
  int direction = 0;
  // 충돌 방향
  int collisionDirection = -1;

  final double characterSize = 64;
  final double characterSpeed = 80;
  String soundTrackName = 'ukulele';

  late AudioPool yummy;
  late AudioPool applause;
  late DialogBox dialogBox;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 배경
    // 각각의 타일은 16 px이다.
    homeMap = await TiledComponent.load('map.tmx', Vector2.all(16));
    add(homeMap);

    // 오버레이
    overlays.add('OverlayController');

    mapWidth = homeMap.tileMap.map.width * 16.0;
    mapHeight = homeMap.tileMap.map.height * 16.0;

    // 음식 추가
    addBakedGoods(homeMap, this);

    // 친구 추가
    loadFriends(
      friendNumberBloc: friendNumberBloc,
      foodNumberBloc: foodNumberBloc,
      georgePositionBloc: georgePositionBloc,
      homeMap: homeMap,
      game: this,
    );

    // 충돌 타일 추가
    loadObstacles(
      friendNumberBloc: friendNumberBloc,
      foodNumberBloc: foodNumberBloc,
      homeMap: homeMap,
      game: this,
    );

    // 음악
    yummy = await AudioPool.create('audio/sfx/yummy.mp3', maxPlayers: 11);
    applause = await AudioPool.create('audio/sfx/applause.mp3', maxPlayers: 11);
    // applause = await FlameAudio.createPool('sfx/applause.mp3', maxPlayers: 11);
    // yummy = await FlameAudio.createPool('sfx/yummy.mp3', maxPlayers: 11);

    // 텍스트 박스
    dialogBox = DialogBox(
        text: '안녕 내 이름은 조지! \n'
            '만나서 반가워! \n'
            '같이 친구를 찾아보자!',
        game: this,
        georgePositionBloc: georgePositionBloc);
    // add(dialogBox);

    // 배경
    // Sprite backgroundSprite = await loadSprite('village.gif');
    // background = SpriteComponent()
    //   ..sprite = backgroundSprite
    //   ..size = backgroundSprite.originalSize;

    //add(background);

    // 음악
    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load('sfx/ukulele.mp3');

    // 조지 등장
    george = GeorgeComponent(
      game: this,
      size: Vector2.all(characterSize),
      notiOverlayBloc: notiOverlayBloc,
    )
      ..position = Vector2(529, 128)
      ..debugMode = true
      ..size = Vector2.all(characterSize);
    add(george);

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
    direction += 1;
    if (direction > 4) {
      direction = 0;
    }
  }

  void newScene() async {
    String mapFile = 'scene3.tmx';
    print(' new scene');
    friendNumberBloc.add(ResetFriend());
    foodNumberBloc.add(RemoveALLFood());
    notiOverlayBloc.add(EndNotiOverlay());
    FlameAudio.bgm.stop();
    george.removeFromParent();
    print(componentList);
    for(var component in componentList) {
      component.removeFromParent();
    }
    componentList = [];
    print(' 두 번 쨰 $componentList');
    remove(homeMap);

    // 조지 재설정
    george = GeorgeComponent(
      game: this,
      size: Vector2.all(characterSize),
      notiOverlayBloc: notiOverlayBloc,
    )
      ..position = Vector2(300, 128)
      ..debugMode = true
      ..size = Vector2.all(characterSize);
    if (sceneNumber == 2) {
      print('moving to map2');
    }

    homeMap = await TiledComponent.load(mapFile, Vector2.all(16));
    add(homeMap);

    mapWidth = homeMap.tileMap.map.width * 16;
    mapHeight = homeMap.tileMap.map.height * 16;
    direction = 0;
    addBakedGoods(homeMap, this);
    loadFriends(
      homeMap: homeMap,
      game: this,
      friendNumberBloc: friendNumberBloc,
      foodNumberBloc: foodNumberBloc,
      georgePositionBloc: georgePositionBloc,
    );
    loadObstacles(
      friendNumberBloc: friendNumberBloc,
      foodNumberBloc: foodNumberBloc,
      homeMap: homeMap,
      game: this,
    );
    add(george);
    camera.followComponent(george,worldBounds: Rect.fromLTRB(0, 0, mapWidth, mapHeight));
  }
}
