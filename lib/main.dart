import 'package:flame/flame.dart';
import 'package:flame/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monster_escape/views/main_menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.util.fullScreen();
  Flame.util.setLandscape();
  FlameAudio()
      .audioCache
      .loadAll(['sfx/jump.ogg', 'sfx/damage.ogg', 'music/track-1.ogg']);
  Flame.bgm.initialize();
  Flame.bgm.play('music/track-1.ogg', volume: 0.25);
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  ));
  // This removes the bottom navigation and fills the empty space
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monster Escape',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainMenu(),
      debugShowCheckedModeBanner: false,
    );
  }
}
