import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:gameforty/enemy/goblin.dart';

class FieldMap {
  static double tileSize = 45;
  static const String wallBottom = 'tile/wall_bottom.png';
  static const String wall = 'tile/wall.png';
  static const String wallTop = 'tile/wall_top.png';
  static const String wallLeft = 'tile/wall_left.png';
  static const String wallBottomLeft = 'tile/wall_bottom_left.png';
  static const String wallRight = 'tile/wall_right.png';
  static const String floor_1 = 'tile/floor_1.png';
  static const String floor_2 = 'tile/floor_2.png';
  static const String floor_3 = 'tile/floor_3.png';
  static const String floor_4 = 'tile/floor_4.png';

  static MapWorld map() {
    List<TileModel> tileList = [];
    List.generate(35, (indexRow) {
      List.generate(70, (indexColumm) {
        if (indexRow == 3 && indexColumm > 2 && indexColumm < 30) {
          tileList.add(TileModel(
            sprite: TileModelSprite(path: wallBottom),
            x: indexColumm.toDouble(),
            y: indexRow.toDouble(),
            collisions: [
              CollisionArea.rectangle(size: Vector2(tileSize, tileSize))
            ],
            width: tileSize,
            height: tileSize,
          ));
          return;
        }
        if (indexRow == 4 && indexColumm > 2 && indexColumm < 30) {
          tileList.add(TileModel(
            sprite: TileModelSprite(path: wall),
            x: indexColumm.toDouble(),
            y: indexRow.toDouble(),
            collisions: [
              CollisionArea.rectangle(size: Vector2(tileSize, tileSize))
            ],
            width: tileSize,
            height: tileSize,
          ));
          return;
        }

        if (indexRow == 9 && indexColumm > 2 && indexColumm < 30) {
          tileList.add(TileModel(
            sprite: TileModelSprite(path: wallTop),
            x: indexColumm.toDouble(),
            y: indexRow.toDouble(),
            collisions: [
              CollisionArea.rectangle(size: Vector2(tileSize, tileSize))
            ],
            width: tileSize,
            height: tileSize,
          ));
          return;
        }

        if (indexRow > 4 &&
            indexRow < 9 &&
            indexColumm > 2 &&
            indexColumm < 30) {
          tileList.add(
            TileModel(
              sprite: TileModelSprite(path: randomFloor()),
              x: indexColumm.toDouble(),
              y: indexRow.toDouble(),
              width: tileSize,
              height: tileSize,
            ),
          );
          return;
        }

        if (indexRow > 3 && indexRow < 9 && indexColumm == 2) {
          tileList.add(TileModel(
            sprite: TileModelSprite(path: wallLeft),
            x: indexColumm.toDouble(),
            y: indexRow.toDouble(),
            collisions: [
              CollisionArea.rectangle(size: Vector2(tileSize, tileSize))
            ],
            width: tileSize,
            height: tileSize,
          ));
        }
        if (indexRow == 9 && indexColumm == 2) {
          tileList.add(TileModel(
            sprite: TileModelSprite(path: wallBottomLeft),
            x: indexColumm.toDouble(),
            y: indexRow.toDouble(),
            collisions: [
              CollisionArea.rectangle(size: Vector2(tileSize, tileSize))
            ],
            width: tileSize,
            height: tileSize,
          ));
        }

        if (indexRow > 3 && indexRow < 9 && indexColumm == 30) {
          tileList.add(TileModel(
            sprite: TileModelSprite(path: wallRight),
            x: indexColumm.toDouble(),
            y: indexRow.toDouble(),
            collisions: [
              CollisionArea.rectangle(size: Vector2(tileSize, tileSize))
            ],
            width: tileSize,
            height: tileSize,
          ));
        }
      });
    });

    return MapWorld(tileList);
  }

  static List<Enemy> enemies() {
    return [
      Goblin(getRelativeTilePosition(14, 6)),
      Goblin(getRelativeTilePosition(25, 6)),
    ];
  }

  static String randomFloor() {
    int p = Random().nextInt(6);
    switch (p) {
      case 0:
        return floor_1;
      case 1:
        return floor_2;
      case 2:
        return floor_3;
      case 3:
        return floor_4;
      case 4:
        return floor_3;
      case 5:
        return floor_4;
      default:
        return floor_1;
    }
  }

  static Vector2 getRelativeTilePosition(int x, int y) {
    return Vector2(
      (x * tileSize).toDouble(),
      (y * tileSize).toDouble(),
    );
  }
}
