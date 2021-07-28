import 'package:flutter/material.dart';
import 'package:monster_escape/views/main_menu.dart';

class GameOver extends StatelessWidget {
  final int score;
  final Function onRestartPress;

  const GameOver({required this.score, required this.onRestartPress});

  @override
  Widget build(BuildContext context) {
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
                    bottom: 10.0,
                  ),
                  child: Text(
                    'GAMEOVER',
                    style: TextStyle(
                        fontFamily: 'Squirk-RMvV',
                        fontSize: 65.0,
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
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 17.5,
                  ),
                  child: Text(
                    'YOUR SCORE:  ${score}',
                    style: TextStyle(
                        fontFamily: 'Squirk-RMvV',
                        fontSize: 35.0,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              // bottomLeft
                              offset: Offset(-3, -3),
                              color: Colors.black),
                          Shadow(
                              // bottomRight
                              offset: Offset(3, -3),
                              color: Colors.black),
                          Shadow(
                              // topRight
                              offset: Offset(3, 3),
                              color: Colors.black),
                          Shadow(
                              // topLeft
                              offset: Offset(-3, 3),
                              color: Colors.black),
                        ]),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              onRestartPress.call();
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Image(
                                image:
                                    AssetImage('assets/images/gui/restart.png'),
                                fit: BoxFit.contain,
                              ),
                              height: 70,
                              width: 70,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 5.0,
                          ),
                          child: Text(
                            "RESTART",
                            style: TextStyle(
                                fontFamily: 'Squirk-RMvV',
                                fontSize: 20.0,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                      // bottomLeft
                                      offset: Offset(-2, -2),
                                      color: Colors.black),
                                  Shadow(
                                      // bottomRight
                                      offset: Offset(2, -2),
                                      color: Colors.black),
                                  Shadow(
                                      // topRight
                                      offset: Offset(2, 2),
                                      color: Colors.black),
                                  Shadow(
                                      // topLeft
                                      offset: Offset(-2, 2),
                                      color: Colors.black),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 30),
                    Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => MainMenu(),
                                ),
                              );
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Image(
                                image:
                                    AssetImage('assets/images/gui/close.png'),
                                fit: BoxFit.contain,
                              ),
                              height: 70,
                              width: 70,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 5.0,
                          ),
                          child: Text(
                            "QUIT",
                            style: TextStyle(
                                fontFamily: 'Squirk-RMvV',
                                fontSize: 20.0,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                      // bottomLeft
                                      offset: Offset(-2, -2),
                                      color: Colors.black),
                                  Shadow(
                                      // bottomRight
                                      offset: Offset(2, -2),
                                      color: Colors.black),
                                  Shadow(
                                      // topRight
                                      offset: Offset(2, 2),
                                      color: Colors.black),
                                  Shadow(
                                      // topLeft
                                      offset: Offset(-2, 2),
                                      color: Colors.black),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
