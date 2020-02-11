import 'package:flutter/material.dart';

class EndGame extends StatelessWidget {
  final int playerWon;
  const EndGame(this.playerWon, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          (playerWon == 0) ? "Nerešeno" : "Pobedio je $playerWon. igrač",
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
