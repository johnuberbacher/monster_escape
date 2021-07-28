import 'package:flutter/material.dart';
import 'package:monster_escape/game.dart';

class GameScreen extends StatelessWidget {
  final MainGame _mainGame = MainGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainGame.widget,
    );
  }
}
