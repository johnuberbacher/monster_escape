import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/animation.dart' as anim;
import 'package:flame/spritesheet.dart';
import 'package:flame/time.dart';
import 'package:flutter/material.dart';
import 'package:monster_escape/util/constants.dart';

class Player extends AnimationComponent {
  late anim.Animation _playerRunAnimation;
  late anim.Animation _playerHitAnimation;
  late anim.Animation _playerJumpAnimation;
  late Size size;
  late bool _isHit;
  late Timer _timer;
  late ValueNotifier<int> life;

  Player() : super.empty() {
    final playerSpriteSheet = SpriteSheet(
      imageName: 'players/player1.png',
      textureWidth: 72,
      textureHeight: 72,
      columns: 17,
      rows: 1,
    );
    _playerRunAnimation =
        playerSpriteSheet.createAnimation(0, from: 6, to: 13, stepTime: 0.15);
    _playerJumpAnimation =
        playerSpriteSheet.createAnimation(0, from: 0, to: 5, stepTime: 0.3);
    _playerHitAnimation =
        playerSpriteSheet.createAnimation(0, from: 14, to: 16, stepTime: 0.25);
    this.animation = _playerRunAnimation;

    this._timer = Timer(1, callback: () {
      _playerRunAnimation;
    });

    _isHit = false;
    this.anchor = Anchor.center;
    life = ValueNotifier(lives);
  }

  @override
  void resize(Size size) {
    super.resize(size);
    // 8 = number of players that can fit horizontally on screen
    this.height = this.width = size.width / 8;
    this.x = this.width;
    y = size.height - groundHeight - this.height / 2;
    playerMaxY = y;
    this.size = size;
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

    _timer.update(t);
  }

  bool checkFloor() {
    return (y >= playerMaxY);
  }

  void playerRun() {
    _isHit = false;
    animation = _playerRunAnimation;
  }

  void playerJump() {
    if (checkFloor()) {
      animation = _playerJumpAnimation;
      playerSpeedY = -WidgetsBinding.instance!.window.physicalSize.height / 2;
      debugPrint(playerSpeedY.toString());
    }
  }

  void playerHit() {
    if (!_isHit) {
      this.animation = _playerHitAnimation;
      life.value -= 1;
      debugPrint("hit");
      _timer.start();
      _isHit = true;
    }
  }
}
