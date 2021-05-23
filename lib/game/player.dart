import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'dart:ui';

class Player extends AnimationComponent {
  Player() : super.empty() {
    final playerSpriteSheet = SpriteSheet(
      imageName: 'DinoSprites - doux.png',
      textureWidth: 24,
      textureHeight: 24,
      columns: 24,
      rows: 1,
    );
    final playerRunAnimation =
        playerSpriteSheet.createAnimation(0, from: 4, to: 10, stepTime: 0.1);

    this.animation = playerRunAnimation;
  }

  @override
  void resize(Size size) {
    super.resize(size);
    this.height = this.width = size.width / 10;
    this.x = this.width;
    // ground is 32px tall
    this.y = size.height - 32 - this.height + 10;
  }
}
