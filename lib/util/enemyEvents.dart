import 'dart:math';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';
import 'package:monster_escape/game/enemy.dart';
import 'package:monster_escape/game/game.dart';

class EnemyEvents extends Component with HasGameRef<MainGame> {
  Random _random = Random();
  late Timer _timer = Timer(4, repeat: true, callback: () {});
  int spawnRate = 0;

  EnemyEvents() {
    _timer = Timer(4, repeat: true, callback: () {
      spawnEnemy();
    });
  }

  void spawnEnemy() {
    final randomNumber = _random.nextInt(EnemyType.values.length);
    final randomEnemyType = EnemyType.values.elementAt(randomNumber);
    final spawnedEnemy = Enemy(randomEnemyType);
    gameRef.addLater(spawnedEnemy);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void render(Canvas c) {}

  @override
  void update(double t) {
    _timer.update(t);

    var newSpawnRate = gameRef.score;
  }
}
