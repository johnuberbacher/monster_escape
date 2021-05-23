import 'package:flame/components/parallax_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flutter/cupertino.dart';
import 'package:monster_escape/game/player.dart';

class MainGame extends BaseGame {
  late Player _player;
  late ParallaxComponent _parallaxComponent;

  MainGame() {
    _player = Player();

    _parallaxComponent = ParallaxComponent(
      [
        ParallaxImage('backgrounds/bg1/plx-1.png'),
        ParallaxImage('backgrounds/bg1/plx-2.png'),
        ParallaxImage('backgrounds/bg1/plx-3.png'),
        ParallaxImage('backgrounds/bg1/plx-4.png'),
        ParallaxImage('backgrounds/bg1/plx-5.png'),
        ParallaxImage('backgrounds/bg1/plx-6.png', fill: LayerFill.none),
      ],
      baseSpeed: Offset(100, 0),
      layerDelta: Offset(20, 0),
    );

    add(_parallaxComponent);
    _player = Player();
    add(_player);
  }
}
