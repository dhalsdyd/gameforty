import 'package:bonfire/bonfire.dart';

import 'package:flutter/material.dart';
import 'package:gameforty/interface/bar_life_component.dart';
import 'package:gameforty/player/knight.dart';

class KnightInterface extends GameInterface {
  static const followerWidgetTestId = 'BUTTON';

  @override
  void onMount() {
    add(BarLifeComponent());
    add(InterfaceComponent(
      spriteUnselected: Sprite.load('blue_button1.png'),
      spriteSelected: Sprite.load('blue_button2.png'),
      size: Vector2(40, 40),
      id: 5,
      position: Vector2(150, 20),
      onTapComponent: (selected) {
        final player = gameRef.player;
        if (player != null) {
          (player as Knight).execShowEmote();
        }
      },
    ));
    add(InterfaceComponent(
      spriteUnselected: Sprite.load('blue_button1.png'),
      spriteSelected: Sprite.load('blue_button2.png'),
      size: Vector2(40, 40),
      id: 5,
      position: Vector2(200, 20),
      selectable: true,
      onTapComponent: (selected) {
        if (gameRef.player != null) {
          (gameRef.player as Knight).changeControllerToVisibleEnemy();
        }
      },
    ));
    add(InterfaceComponent(
      spriteUnselected: Sprite.load('blue_button1.png'),
      spriteSelected: Sprite.load('blue_button2.png'),
      size: Vector2(40, 40),
      id: 5,
      position: Vector2(250, 20),
      selectable: true,
      onTapComponent: (selected) {
        if (!selected && FollowerWidget.isVisible(followerWidgetTestId)) {
          FollowerWidget.remove(followerWidgetTestId);
          return;
        }
        gameRef.player?.let((player) {
          FollowerWidget.show(
            identify: followerWidgetTestId,
            context: context,
            target: player,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  print('Tapped');
                },
                child: const Text('Tap here'),
              ),
            ),
            align: const Offset(0, -55),
          );
        });
      },
    ));
    add(InterfaceComponent(
      spriteUnselected: Sprite.load('blue_button1.png'),
      spriteSelected: Sprite.load('blue_button2.png'),
      size: Vector2(40, 40),
      id: 5,
      position: Vector2(300, 20),
      selectable: false,
      onTapComponent: (selected) {
        if (gameRef.colorFilter?.config.color == null) {
          gameRef.colorFilter?.animateTo(
            Colors.red.withOpacity(0.5),
          );
        } else {
          gameRef.colorFilter?.animateTo(Colors.transparent, onFinish: () {
            gameRef.colorFilter?.config.color = null;
          });
        }
      },
    ));
    add(TextInterfaceComponent(
      text: 'Text example',
      textConfig: const TextStyle(
        color: Colors.white,
      ),
      id: 5,
      position: Vector2(350, 20),
      onTapComponent: (selected) {
        if (gameRef.player != null) {
          (gameRef.player as Knight).execShowEmote();
        }
      },
    ));
    super.onMount();
  }
}
