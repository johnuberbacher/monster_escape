import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:monster_escape/game/enemy.dart';
import 'package:monster_escape/game/player.dart';
import 'package:monster_escape/util/enemy_manager.dart';
import 'package:monster_escape/util/constants.dart';
import 'package:monster_escape/widgets/pause_menu.dart';
import 'package:monster_escape/widgets/game_over.dart';

class MainGame extends BaseGame with TapDetector, HasWidgetsOverlay {
  late Player _player;
  late ParallaxComponent _parallaxComponent;
  late ParallaxComponent _parallaxForeground;
  late TextComponent _scoreText;
  late EventManager _enemyManager;
  late double _elaspedTime = 0.0;
  late int score;
  bool _isGameOver = false;
  bool _isGamePaused = false;

  MainGame() {
    _player = Player();
    _parallaxComponent = ParallaxComponent(
      [
        ParallaxImage('backgrounds/plx-1-${Random().nextInt(2) + 1}.png'),
        ParallaxImage('backgrounds/plx-2.png'),
        ParallaxImage('backgrounds/plx-3.png'),
        ParallaxImage('backgrounds/plx-4.png'),
        ParallaxImage('backgrounds/plx-5.png'),
      ],
      baseSpeed: Offset(200, 0),
      layerDelta: Offset(20, 0),
    );
    _parallaxForeground = ParallaxComponent(
      [
        ParallaxImage('backgrounds/bg1/plx-7.png', fill: LayerFill.none),
      ],
      baseSpeed: Offset(200, 0),
      layerDelta: Offset(20, 0),
    );

    _enemyManager = EventManager();
    add(_enemyManager);
    add(_parallaxComponent);
    add(_parallaxForeground);
    add(_player);
    //var enemy = Enemy(EnemyType.Tyran2);
    //add(enemy);

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

    @override
    void lifecycleStateChange(AppLifecycleState state) {
      switch (state) {
        case AppLifecycleState.resumed:
          break;
        case AppLifecycleState.inactive:
          this.pauseGame();
          break;
        case AppLifecycleState.paused:
          this.pauseGame();
          break;
        case AppLifecycleState.detached:
          this.pauseGame();
          break;
      }
    }

    addWidgetOverlay('GUI', _buildGUI());
  }

  @override
  void resize(Size size) {
    super.resize(size);
    _scoreText.setByPosition(
        Position(((size.width / 2) - (_scoreText.width / 2)), 15));
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    if (!_isGameOver && !_isGamePaused) {
      _player.playerJump();
    }
  }

  @override
  void update(double t) {
    super.update(t);

    _elaspedTime += t;
    _scoreText.text = score.toString();
    if (_elaspedTime > (1 / 1)) {
      _elaspedTime = 0.0;
      score += 1;
    }
    //score += (60 * t).toInt();
    //_scoreText.text = (score.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},"));

    components.whereType<Enemy>().forEach((enemy) {
      if (_player.distance(enemy) < 70) {
        _player.playerHit();
      }
    });

    if (_player.life.value <= 0) {
      gameOver();
    }
  }

  Widget _buildGUI() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                pauseGame();
              },
              child: Container(
                color: Colors.transparent,
                child: Image(
                  image: AssetImage('assets/images/gui/pause.png'),
                  fit: BoxFit.contain,
                ),
                height: 50,
                width: 50,
                //height: WidgetsBinding.instance!.window.physicalSize.width / 30,
                //width: WidgetsBinding.instance!.window.physicalSize.width / 30,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ValueListenableBuilder(
                valueListenable: _player.life,
                builder: (BuildContext context, value, Widget? child) {
                  final List<Widget> hearts = [];
                  for (int i = 0; i < lives; ++i) {
                    hearts.add(
                      Container(
                        margin: const EdgeInsets.only(
                          right: 10.0,
                        ),
                        color: Colors.transparent,
                        child: Image(
                          image: (i < (value as num))
                              ? AssetImage('assets/images/gui/heart.png')
                              : AssetImage('assets/images/gui/deplete.png'),
                          fit: BoxFit.contain,
                        ),
                        height: 30,
                        width: 30,
                      ),
                    );
                  }
                  return Row(
                    children: hearts.reversed.toList(),
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 5.0,
                ),
                color: Colors.transparent,
                child: Image(
                  image: AssetImage('assets/images/players/avatar1.png'),
                  fit: BoxFit.contain,
                ),
                height: 60,
                width: 60,
                //height: WidgetsBinding.instance!.window.physicalSize.width / 30,
                //width: WidgetsBinding.instance!.window.physicalSize.width / 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void pauseGame() {
    pauseEngine();
    if (!_isGameOver) {
      _isGamePaused = true;
      addWidgetOverlay(
        'PauseMenu',
        PauseMenu(
          onResumePress: resumeGame,
        ),
      );
    }
  }

  void gameOver() {
    pauseEngine();
    _isGameOver = true;
    addWidgetOverlay(
      'GameOver',
      GameOver(
        score: score,
        onRestartPress: reset,
      ),
    );
    // AudioManager.instance.pauseBgm();
  }

  void resumeGame() {
    removeWidgetOverlay('PauseMenu');
    _isGamePaused = false;
    resumeEngine();
  }

  void reset() {
    removeWidgetOverlay('GameOver');
    debugPrint("here");
    this.score = 0;
    _player.life.value = lives;
    _player.playerRun();
    _enemyManager.reset();
    components.whereType<Enemy>().forEach(
      (enemy) {
        this.markToRemove(enemy);
      },
    );
    _isGameOver = false;
    resumeGame();
  }
}
