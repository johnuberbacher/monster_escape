import 'dart:ui';
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
import 'package:monster_escape/util/enemyEvents.dart';
import 'package:monster_escape/util/constants.dart';

class MainGame extends BaseGame with TapDetector, HasWidgetsOverlay {
  late Player _player;
  late ParallaxComponent _parallaxComponent;
  late ParallaxComponent _parallaxForeground;
  late TextComponent _scoreText;
  late EnemyEvents _enemyManager;
  late double _elaspedTime = 0.0;
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

    _enemyManager = EnemyEvents();
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
    _player.playerJump();
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
      if (_player.distance(enemy) < 72) {
        _player.playerHit();
      }
    });
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
                      (i < (value as num))
                          ? Container(
                              margin: const EdgeInsets.only(
                                right: 10.0,
                              ),
                              color: Colors.transparent,
                              child: Image(
                                image:
                                    AssetImage('assets/images/gui/heart.png'),
                                fit: BoxFit.contain,
                              ),
                              height: 30,
                              width: 30,
                            )
                          : Container(
                              height: 30,
                            ),
                    );
                  }
                  return Row(
                    children: hearts,
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

  Widget _buildPauseMenu() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      height: WidgetsBinding.instance!.window.physicalSize.width,
      width: WidgetsBinding.instance!.window.physicalSize.width,
      child: Center(
        child: Container(
            width: 500,
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/gui/bg.png'),
                fit: BoxFit.contain,
              ),
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 50.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 30.0,
                  ),
                  child: Text(
                    "PAUSED",
                    style: TextStyle(
                        fontFamily: 'Squirk-RMvV',
                        fontSize: 80.0,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              // bottomLeft
                              offset: Offset(-5, -5),
                              color: Colors.black),
                          Shadow(
                              // bottomRight
                              offset: Offset(5, -5),
                              color: Colors.black),
                          Shadow(
                              // topRight
                              offset: Offset(5, 5),
                              color: Colors.black),
                          Shadow(
                              // topLeft
                              offset: Offset(-5, 5),
                              color: Colors.black),
                        ]),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      resumeGame();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Image(
                        image: AssetImage('assets/images/gui/play.png'),
                        fit: BoxFit.contain,
                      ),
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void pauseGame() {
    pauseEngine();
    addWidgetOverlay('PauseMenu', _buildPauseMenu());
  }

  void resumeGame() {
    removeWidgetOverlay('PauseMenu');
    resumeEngine();
  }
}
