import 'dart:ui';
import 'package:flame/components/animation_component.dart';
import 'package:flame/animation.dart' as anim;
import 'package:flame/spritesheet.dart';
import 'package:flutter/material.dart';
import 'package:monster_escape/util/constants.dart';

class Enemy extends AnimationComponent {
  double enemySpeed = 200;
  late anim.Animation _enemyRunAnimation;
  Enemy() : super.empty() {
    final enemySpriteSheet = SpriteSheet(
      imageName: 'enemy/enemy1/spritesheet.png',
      textureWidth: 128,
      textureHeight: 76,
      columns: 8,
      rows: 1,
    );

    _enemyRunAnimation =
        enemySpriteSheet.createAnimation(0, from: 0, to: 7, stepTime: 0.15);

    this.animation = _enemyRunAnimation;
  }

  @override
  void resize(Size size) {
    super.resize(size);

    this.height = size.width / 6;
    this.width = size.width / 4;
    this.x = size.width + this.width;

    // ground is 32px tall
    // y = size.height - 32 - height + 10;
    y = size.height - groundHeight - height;
  }

  @override
  void update(double t) {
    super.update(t);
    this.x -= enemySpeed * t;
  }
}
