import 'package:flutter/material.dart';
import 'package:tablic/player.dart';

class Points extends StatefulWidget {
  final List<Player> players;
  Points({Key key, @required this.players}) : super(key: key);

  @override
  PointsState createState() => PointsState();
}

class PointsState extends State<Points> {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: <TableRow>[
        TableRow(
          children: <TableCell>[
            TableCell(child: Text("")),
            ...widget.players.map(
              (player) => TableCell(
                child: Text("${player.cards.length}"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
