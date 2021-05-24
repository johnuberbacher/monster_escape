import 'dart:ui';
import 'package:flame/components/animation_component.dart';
import 'package:flame/animation.dart' as anim;
import 'package:flame/spritesheet.dart';
import 'package:flutter/material.dart';

class Player extends AnimationComponent {
  late anim.Animation _playerRunAnimation;
  late anim.Animation _playerHitAnimation;
  double playerSpeedY = 0.0;
  double playerMaxY = 0.0;
  static const double gravity = 1000;

  Player() : super.empty() {
    final playerSpriteSheet = SpriteSheet(
      imageName: 'DinoSprites - doux.png',
      textureWidth: 24,
      textureHeight: 24,
      columns: 24,
      rows: 1,
    );
    _playerRunAnimation =
        playerSpriteSheet.createAnimation(0, from: 4, to: 10, stepTime: 0.1);
    _playerHitAnimation =
        playerSpriteSheet.createAnimation(0, from: 14, to: 16, stepTime: 0.1);
    animation = _playerRunAnimation;
  }

  @override
  void resize(Size size) {
    super.resize(size);
    height = width = size.width / 10;
    x = width;
    // ground is 32px tall
    y = size.height - 32 - height + 10;
    playerMaxY = y;
  }

  @override
  void update(double t) {
    super.update(t);
    // final velocity = initial velocity + gravity * t
    playerSpeedY += gravity * t;
    // distance = speed * t
    y += playerSpeedY * t;
    if (checkFloor()) {
      y = playerMaxY;
      playerSpeedY = 0.0;
    }
  }

  bool checkFloor() {
    return (y >= playerMaxY);
  }

  void playerRun() {
    animation = _playerRunAnimation;
  }

  void playerHit() {
    animation = _playerHitAnimation;
  }

  void playerJump() {
    if (checkFloor()) {
      playerSpeedY = -500;
    }
  }
}
