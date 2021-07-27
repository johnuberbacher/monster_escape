import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monster_escape/util/audio_util.dart';
import 'views/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.util.fullScreen();
  Flame.util.setLandscape();
  AudioUtil.instance.init(['track-1.ogg', 'jump.ogg']);
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Monster Escape'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MainGame game;

  @override
  void initState() {
    super.initState();
    game = MainGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: game.widget,
    );
  }
}
