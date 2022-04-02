import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:gameforty/map/map.dart';
import 'package:gameforty/utils/common_sprite_sheet.dart';
import 'package:gameforty/utils/enemy_sprite_sheet.dart';

import 'goblin_controller.dart';

class Goblin extends SimpleEnemy
    with
        ObjectCollision,
        JoystickListener,
        MovementByJoystick,
        AutomaticRandomMovement,
        UseStateController<GoblinController> {
  Goblin(Vector2 position)
      : super(
          animation: EnemySpriteSheet.simpleDirectionAnimation,
          position: position,
          size: Vector2.all(FieldMap.tileSize * 0.8),
          speed: FieldMap.tileSize * 1.6,
          life: 100,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(
              FieldMap.tileSize * 0.4,
              FieldMap.tileSize * 0.4,
            ),
            align: Vector2(
              FieldMap.tileSize * 0.2,
              FieldMap.tileSize * 0.2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void render(Canvas c) {
    super.render(c);
    drawDefaultLifeBar(
      c,
      borderRadius: BorderRadius.circular(5),
      borderWidth: 2,
    );
  }

  @override
  void die() {
    super.die();
    gameRef.add(
      AnimatedObjectOnce(
        animation: CommonSpriteSheet.smokeExplosion,
        position: position,
        size: Vector2.all(FieldMap.tileSize),
      ),
    );
    removeFromParent();
  }

  void execAttackRange(double damage) {
    if (gameRef.player != null && gameRef.player?.isDead == true) return;
    simpleAttackRange(
      animationRight: CommonSpriteSheet.fireBallRight,
      animationLeft: CommonSpriteSheet.fireBallLeft,
      animationUp: CommonSpriteSheet.fireBallTop,
      animationDown: CommonSpriteSheet.fireBallBottom,
      animationDestroy: CommonSpriteSheet.explosionAnimation,
      id: 35,
      size: Vector2.all(width * 0.9),
      damage: damage,
      speed: FieldMap.tileSize * 3,
      collision: CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2.all(width / 2),
            align: Vector2(width * 0.25, width * 0.25),
          ),
        ],
      ),
      lightingConfig: LightingConfig(
        radius: width / 2,
        blurBorder: width,
        color: Colors.orange.withOpacity(0.3),
      ),
    );
  }

  void execAttack(double damage) {
    if (gameRef.player != null && gameRef.player?.isDead == true) return;
    simpleAttackMelee(
      size: Vector2.all(width),
      damage: damage / 2,
      interval: 400,
      sizePush: FieldMap.tileSize / 2,
      animationDown: CommonSpriteSheet.blackAttackEffectBottom,
      animationLeft: CommonSpriteSheet.blackAttackEffectLeft,
      animationRight: CommonSpriteSheet.blackAttackEffectRight,
      animationUp: CommonSpriteSheet.blackAttackEffectTop,
    );
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, dynamic identify) {
    showDamage(
      damage,
      config: TextStyle(
        fontSize: width / 3,
        color: Colors.white,
      ),
    );
    super.receiveDamage(attacker, damage, identify);
  }

  @override
  void joystickAction(JoystickActionEvent event) {}

  @override
  void moveTo(Vector2 position) {}
}
