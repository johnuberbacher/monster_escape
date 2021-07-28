import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monster_escape/views/game_screen.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/gui/mainmenu.png'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 15.0,
              ),
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/gui/title.png'),
                fit: BoxFit.contain,
              )),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.4,
              //
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/gui/mainmenu-bg.png'),
                fit: BoxFit.contain,
              )),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => GameScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 4,
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: Text(
                        "Tap to Play!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Squirk-RMvV',
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
