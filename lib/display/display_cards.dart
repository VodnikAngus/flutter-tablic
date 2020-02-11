import 'dart:ui';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablic/mehanics/state.dart';
import 'package:tablic/play_card.dart';

class DisplayCard extends StatefulWidget {
  final PlayCard card;
  final bool flip;
  final selected;
  const DisplayCard({
    Key key,
    @required this.card,
    this.flip = false,
    this.selected = false,
  }) : super(key: key);

  @override
  _DisplayCardState createState() => _DisplayCardState();
}

class _DisplayCardState extends State<DisplayCard> {
  Widget flipped() {
    return Stack(
      children: <Widget>[
        shown(),
        Container(
          color: Colors.blue[300],
        ),
      ],
    );
  }

  StatelessWidget shown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(3)),
        color: widget.selected ? Colors.grey[300] : Colors.white,
        border: widget.selected
            ? Border.all(color: Colors.grey[800], width: 5)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FractionallySizedBox(
              widthFactor: 1 / 2,
              child: Image.asset(
                'assets/cards/${widget.card.color()}/${widget.card.displayName()}.png',
                semanticLabel: widget.card.displayName(),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 1 / 2,
              child: Image.asset(
                'assets/cards/${widget.card.suit.toString().replaceAll("suits.", "")}.png',
                semanticLabel: widget.card.displayName(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: .9,
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          elevation: 4,
          child: widget.flip ? flipped() : shown(),
        ),
      ),
    );
  }
}

class DisplayCardRow extends StatelessWidget {
  final int playerIndex;
  const DisplayCardRow({
    Key key,
    this.playerIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CardsState>(
      builder: (context, state, child) => RowSuper(
        children: state.players[playerIndex].cards
            .map(
              (card) => GestureDetector(
                onTap: () {
                  if (state.currentPlayer == playerIndex) {
                    if (state.selectedCards.isEmpty) {
                      state.playCards.add(card);
                      state.players[playerIndex].cards.remove(card);
                      state.players[playerIndex].notify();
                      state.nextPlayer();
                    } else {
                      if (state.players[playerIndex]
                          .collectCards(card, state.selectedCards)) {
                        for (PlayCard removecard in state.selectedCards) {
                          state.playCards.remove(removecard);
                        }
                        state.selectedCards.clear();
                        state.lastCollected = playerIndex;
                        state.nextPlayer();
                      }
                    }
                    if (state.playCards.isEmpty)
                      state.players[playerIndex].tables++;
                  }
                },
                child: DisplayCard(
                  card: card,
                  flip: !state.players[playerIndex].isHuman &&
                      state.players[playerIndex].show != card,
                ),
              ),
            )
            .toList(),
        innerDistance: -25,
      ),
    );
  }
}
