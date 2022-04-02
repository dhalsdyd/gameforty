import 'package:bonfire/bonfire.dart';

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get example => SpriteAnimation.load(
        "player/example.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(49, 41),
        ),
      );
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        "player/hero_idle.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(48, 40),
        ),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        "player/hero_run.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(49, 41),
        ),
      );
  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        runRight: runRight,
      );
}
