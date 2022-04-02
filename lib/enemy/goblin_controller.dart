import 'package:bonfire/bonfire.dart';
import 'package:gameforty/map/map.dart';

import 'goblin.dart';

class GoblinController extends StateController<Goblin> {
  double attack = 20;
  bool _seePlayerToAttackMelee = false;
  bool enableBehaviors = true;

  @override
  void update(double dt) {
    if (!enableBehaviors) return;
    if (component == null) return;

    _seePlayerToAttackMelee = false;

    component?.seeAndMoveToPlayer(
      closePlayer: (player) {
        component?.execAttack(attack);
      },
      observed: () {
        _seePlayerToAttackMelee = true;
      },
      radiusVision: FieldMap.tileSize * 1.5,
    );

    if (!_seePlayerToAttackMelee) {
      component?.seeAndMoveToAttackRange(
        minDistanceFromPlayer: FieldMap.tileSize * 2,
        positioned: (p) {
          component?.execAttackRange(attack);
        },
        radiusVision: FieldMap.tileSize * 3,
        notObserved: () {
          component?.runRandomMovement(
            dt,
            speed: component!.speed / 2,
            maxDistance: (FieldMap.tileSize * 3).toInt(),
          );
        },
      );
    }
  }
}
