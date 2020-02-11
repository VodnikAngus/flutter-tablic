import 'package:flutter/widgets.dart';

enum suits { diamonds, clubs, hearts, spades }
enum cardColor { black, red }

class PlayCard {
  final int number;
  final suits suit;
  PlayCard({@required this.number, @required this.suit});

  String color() {
    if (suit == suits.diamonds || suit == suits.hearts)
      return "red";
    else
      return "black";
  }

  String displayName() {
    switch (number) {
      case 1:
        return "A";
        break;
      case 12:
        return "J";
        break;
      case 13:
        return "Q";
        break;
      case 14:
        return "K";
        break;
      default:
        return '$number';
    }
  }

  String displaySuit() {
    switch (suit) {
      case suits.clubs:
        return '♣';
        break;
      case suits.diamonds:
        return '♦';
        break;
      case suits.hearts:
        return '♥';
        break;
      case suits.spades:
        return '♠';
        break;
      default:
        return 'E';
    }
  }

  int points() {
    if (number == 10 && suit == suits.diamonds) return 2;

    if (number == 1 || number >= 10 || (number == 2 && suit == suits.clubs))
      return 1;

    return 0;
  }

  @override
  String toString() {
    return '${displayName()} ${displaySuit()}';
  }
}
