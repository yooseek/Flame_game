import 'package:flame_tiled/flame_tiled.dart';
import 'package:testtesttest/characters/baked_good_component.dart';
import 'package:flame/components.dart';
import 'package:testtesttest/view/flame_animation.dart';
import 'package:tiled/tiled.dart';

void addBakedGoods(TiledComponent homeMap, FlameAnimation game) async {
  final bakedGoodsGroup = homeMap.tileMap.getLayer<ObjectGroup>('baked_goods');

  for (var bakedGood in bakedGoodsGroup!.objects) {
    if (bakedGood.class_.isNotEmpty) {
      final imgName = bakedGood.class_;

      game.add(BakedGoodComponent(
        size: Vector2(
          bakedGood.width,
          bakedGood.height,
        ),
        foodNumberBloc: game.foodNumberBloc,
        bakedGoodName : imgName,
      )
        ..position = Vector2(bakedGood.x, bakedGood.y)
        ..sprite = await game.loadSprite('$imgName.png')
        ..width = bakedGood.width
        ..height = bakedGood.height
        ..debugMode = true);
    }
  }
}
