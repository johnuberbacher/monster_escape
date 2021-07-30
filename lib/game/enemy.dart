import 'dart:math';
import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/animation.dart' as anim;
import 'package:flame/spritesheet.dart';
import 'package:flutter/material.dart';
import 'package:monster_escape/util/constants.dart';

enum EnemyType { Tyran1, Tyran2, Flying1 }

class EnemyData {
  final String imageName;
  final int textureWidth;
  final int textureHeight;
  final int nColumns;
  final int nRows;
  final int speed;
  final bool flying;

  EnemyData({
    required this.imageName,
    required this.textureWidth,
    required this.textureHeight,
    required this.nColumns,
    required this.nRows,
    required this.speed,
    required this.flying,
  });
}

class Enemy extends AnimationComponent {
  static Map<EnemyType, EnemyData> _enemyDetails = {
    EnemyType.Tyran1: EnemyData(
      imageName: 'enemy/enemy1.png',
      textureWidth: 128,
      textureHeight: 76,
      nColumns: 8,
      nRows: 1,
      speed: 400,
      flying: false,
    ),
    EnemyType.Tyran2: EnemyData(
      imageName: 'enemy/enemy2.png',
      textureWidth: 128,
      textureHeight: 76,
      nColumns: 8,
      nRows: 1,
      speed: 600,
      flying: false,
    ),
    EnemyType.Flying1: EnemyData(
      imageName: 'enemy/enemy3.png',
      textureWidth: 128,
      textureHeight: 76,
      nColumns: 5,
      nRows: 1,
      speed: 500,
      flying: true,
    ),
    EnemyType.Flying1: EnemyData(
      imageName: 'enemy/enemy4.png',
      textureWidth: 128,
      textureHeight: 76,
      nColumns: 5,
      nRows: 1,
      speed: 800,
      flying: true,
    ),
  };
  EnemyData enemyData = _enemyDetails[EnemyType.Tyran1] as EnemyData;
  static Random _random = Random();

  Enemy(EnemyType enemyType) : super.empty() {
    enemyData = _enemyDetails[enemyType] as EnemyData;

    final enemySpriteSheet = SpriteSheet(
      imageName: enemyData.imageName,
      textureWidth: enemyData.textureWidth,
      textureHeight: enemyData.textureHeight,
      columns: enemyData.nColumns,
      rows: enemyData.nRows,
    );

    late anim.Animation _enemyRunAnimation;
    _enemyRunAnimation = enemySpriteSheet.createAnimation(0,
        from: 0, to: (enemyData.nColumns - 1), stepTime: 0.15);

    this.animation = _enemyRunAnimation;
    this.anchor = Anchor.center;
  }

  @override
  void resize(Size size) {
    super.resize(size);

    double scaleWidth = (size.width / 5 / enemyData.textureWidth);
    double scaleHeight = (size.width / 7 / enemyData.textureWidth);

    this.height = enemyData.textureHeight * scaleWidth;
    this.width = enemyData.textureWidth * scaleWidth;

    this.x = size.width + this.width;

    y = size.height - groundHeight - this.height / 2;

    if (enemyData.flying && _random.nextBool()) {
      this.y -= this.height;
    }
  }

  @override
  void update(double t) {
    super.update(t);
    this.x -= enemyData.speed * t;
  }

  @override
  bool destroy() {
    // Enemy can be destroyed once it goes off screen
    return (this.x < (-this.width));
  }
}
