import 'package:bonfire/bonfire.dart';

class EnemySpriteSheet {
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        "enemy/goblin_frame.png",
        SpriteAnimationData.variable(
          amount: 4,
          stepTimes: List.filled(4, 0.1),
          textureSize: Vector2(64, 64),
          amountPerRow: 1,
        ),
      );
  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        "enemy/goblin_frame.png",
        SpriteAnimationData.variable(
          amount: 4,
          stepTimes: List.filled(4, 0.1),
          textureSize: Vector2(64, 64),
          amountPerRow: 2,
        ),
      );
  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        runRight: runRight,
      );
}
