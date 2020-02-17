import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablic/mehanics/state.dart';

class PointsTable extends StatelessWidget {
  const PointsTable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1 / 6,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<CardsState>(
              builder: (context, state, _) => Table(
                children: <TableRow>[
                  for (int i = 0; i < state.players.length; i++)
                    TableRow(
                      children: [
                        TableCell(child: Text("Igrač ${i + 1}")),
                        TableCell(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("${state.players[i].points()}")),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
