import 'dart:ui';
import 'package:flame/components/animation_component.dart';
import 'package:flame/animation.dart' as anim;
import 'package:flame/spritesheet.dart';
import 'package:flutter/material.dart';
import 'package:monster_escape/util/constants.dart';

class Player extends AnimationComponent {
  late anim.Animation _playerRunAnimation;
  late anim.Animation _playerHitAnimation;
  late anim.Animation _playerJumpAnimation;

  Player() : super.empty() {
    final playerSpriteSheet = SpriteSheet(
      imageName: 'players/spritesheet.png',
      textureWidth: 72,
      textureHeight: 72,
      columns: 14,
      rows: 1,
    );
    _playerRunAnimation =
        playerSpriteSheet.createAnimation(0, from: 6, to: 13, stepTime: 0.15);
    _playerHitAnimation =
        playerSpriteSheet.createAnimation(0, from: 0, to: 5, stepTime: 0.1);
    _playerJumpAnimation =
        playerSpriteSheet.createAnimation(0, from: 0, to: 5, stepTime: 0.3);
    animation = _playerRunAnimation;
  }

  @override
  void resize(Size size) {
    super.resize(size);
    // 8 = number of players that can fit horizontally on screen
    this.height = this.width = size.width / 8;
    this.x = this.width;
    y = size.height - groundHeight - height + 10;
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
      animation = _playerRunAnimation;
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
      animation = _playerJumpAnimation;
      playerSpeedY = -550;
    }
  }
}
