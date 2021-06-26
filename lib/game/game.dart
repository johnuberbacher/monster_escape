import 'dart:ui';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:monster_escape/game/player.dart';

class MainGame extends BaseGame with TapDetector {
  late Player _player;
  late ParallaxComponent _parallaxComponent;
  late TextComponent _scoreText;
  late int score;

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
      baseSpeed: Offset(200, 0),
      layerDelta: Offset(20, 0),
    );

    add(_parallaxComponent);
    add(_player);

    score = 0;

    _scoreText = TextComponent(
      score.toString(),
      config: TextConfig(
        fontFamily: 'Squirk-RMvV',
        fontSize: 30.0,
        color: Color(0xFFFFFFFF),
      ),
    );
    add(_scoreText);
  }

  @override
  void resize(Size size) {
    // TODO: implement resize
    super.resize(size);
    _scoreText.setByPosition(
        Position(((size.width / 2) - (_scoreText.width / 2)), 15));
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    _player.playerJump();
  }

  @override
  void update(double t) {
    super.update(t);
    score += (60 * t).toInt();
    _scoreText.text = (score.toString().replaceAllMapped(
        new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},"));
  }
}
