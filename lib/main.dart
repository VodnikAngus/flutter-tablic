import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tablic/display/game_layout.dart';
import 'package:tablic/mehanics/state.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() {
  runApp(Tablic());
}

class Tablic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return ChangeNotifierProvider<CardsState>(
      create: (context) => CardsState(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.green[400],
        ),
        home: GameLayout(),
      ),
    );
  }
}
