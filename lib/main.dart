import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:gameforty/enemy/goblin.dart';
import 'package:gameforty/enemy/goblin_controller.dart';
import 'package:gameforty/interface/bar_life_controller.dart';
import 'package:gameforty/interface/knight_interface.dart';
import 'package:gameforty/map/map.dart';
import 'package:gameforty/player/knight.dart';
import 'package:gameforty/player/knight_controller.dart';
import 'package:gameforty/utils/common_sprite_sheet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();
  await Flame.device.fullScreen();

  BonfireInjector().put((i) => KnightController());
  BonfireInjector().putFactory((i) => GoblinController());
  BonfireInjector().put((i) => BarLifeController());

  runApp(MaterialApp(
    home: GameForty(),
  ));
}

class GameForty extends StatelessWidget implements GameListener {
  GameForty({Key? key}) : super(key: key);

  final GameController _controller = GameController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      FieldMap.tileSize = max(constraints.maxHeight, constraints.maxWidth) / 22;
      return BonfireWidget(
        joystick: Joystick(
          directional: JoystickDirectional(
            spriteBackgroundDirectional: Sprite.load('joystick_background.png'),
            spriteKnobDirectional: Sprite.load('joystick_knob.png'),
            size: 100,
            isFixed: false,
          ),
          actions: [
            JoystickAction(
              actionId: PlayerAttackType.AttackMelee,
              sprite: Sprite.load('joystick_atack.png'),
              align: JoystickActionAlign.BOTTOM_RIGHT,
              size: 80,
              margin: const EdgeInsets.only(bottom: 50, right: 50),
            ),
            JoystickAction(
              actionId: PlayerAttackType.AttackRange,
              sprite: Sprite.load('joystick_atack_range.png'),
              spriteBackgroundDirection: Sprite.load('joystick_background.png'),
              size: 50,
              enableDirection: true,
              margin: const EdgeInsets.only(bottom: 50, right: 160),
            )
          ],
        ),
        player: Knight(
          Vector2((4 * FieldMap.tileSize), (6 * FieldMap.tileSize)),
        ),
        interface: KnightInterface(),
        map: FieldMap.map(),
        enemies: FieldMap.enemies(),
        background: BackgroundColorGame(Colors.blueGrey[900]!),
        gameController: _controller..addListener(this),
        lightingColorGame: Colors.black.withOpacity(0.75),
      );
    });
  }

  @override
  void updateGame() {}

  @override
  void changeCountLiveEnemies(int count) {
    if (count < 2) {
      _addEnemyInWorld();
    }
  }

  void _addEnemyInWorld() {
    double x = FieldMap.tileSize * (4 + Random().nextInt(25));
    double y = FieldMap.tileSize * (5 + Random().nextInt(3));

    final goblin = Goblin(Vector2(x, y));

    _controller.addGameComponent(
      AnimatedObjectOnce(
        animation: CommonSpriteSheet.smokeExplosion,
        size: Vector2.all(FieldMap.tileSize),
        position: goblin.position,
      ),
    );

    _controller.addGameComponent(
      goblin,
    );
  }
}
