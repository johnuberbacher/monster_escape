import 'dart:math';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';
import 'package:monster_escape/game/enemy.dart';
import '../views/game.dart';

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

    /// Incrase spawn rate by 1 for every 5 points/seconds
    var newSpawnLevel = (gameRef.score ~/ 5);
    if (spawnRate < newSpawnLevel) {
      spawnRate = newSpawnLevel;

      // y = 4 / (1 + 0.1 * x)
      var newWaitTime = (4 / (1 + (0.1 * spawnRate)));

      _timer.stop();
      _timer = Timer(newWaitTime, repeat: true, callback: () {
        spawnEnemy();
      });
      _timer.start();
    }
    // var newSpawnRate = gameRef.score;
  }

  void reset() {
    spawnRate = 0;
    _timer = Timer(4, repeat: true, callback: () {
      spawnEnemy();
    });
    _timer.start();
  }
}
