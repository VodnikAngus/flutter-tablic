import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablic/display/display_cards.dart';
import 'package:tablic/display/play_cards.dart';
import 'package:tablic/mehanics/state.dart';

class GameLayout extends StatelessWidget {
  const GameLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Consumer<CardsState>(
              builder: (context, state, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    DisplayCardRow(
                      playerIndex: 0,
                    ),
                    PlayCards(),
                    DisplayCardRow(
                      playerIndex: 1,
                    ),
                  ]
                      .map(
                        (Widget widget) => Expanded(
                          child: Center(child: widget),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
