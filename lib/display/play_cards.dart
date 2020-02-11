import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tablic/display/display_cards.dart';
import 'package:tablic/mehanics/state.dart';

class PlayCards extends StatelessWidget {
  const PlayCards({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<CardsState>(
        builder: (context, state, child) => RowSuper(
          alignment: Alignment.center,
          innerDistance: 15,
          children: state.playCards
              .map(
                (card) => GestureDetector(
                  onTap: () => state.toggleSelected(card),
                  child: DisplayCard(
                    card: card,
                    selected: state.selectedCards.contains(card),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
