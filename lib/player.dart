import 'package:flutter/widgets.dart';
import 'package:tablic/play_card.dart';

class Player with ChangeNotifier {
  Player({this.isHuman = false});
  List<PlayCard> cards = [];
  List<PlayCard> collectedCards = [];
  int mostCards = 0;
  bool isHuman;
  PlayCard show;
  int tables = 0;

  int points() =>
      collectedCards.fold(0, (value, card) => value + card.points()) +
      tables +
      3 * mostCards;

  bool collectCards(PlayCard testCard, List<PlayCard> selectedCards) {
    bool can = canCollect(testCard, selectedCards);
    if (can) {
      collectedCards.addAll([testCard, ...selectedCards]);
      cards.remove(testCard);
    }
    notifyListeners();
    return can;
  }

  notify() {
    notifyListeners();
  }

  bool canCollect(PlayCard testCard, List<PlayCard> selectedCards) {
    List<PlayCard> selectedCardsCopy = [];
    selectedCardsCopy.insertAll(0, selectedCards);
    if (testCard.number == 1) {
      List<PlayCard> test;
      do {
        List<PlayCard> oof = [];
        test = subsetEqual(selectedCardsCopy, oof, 11);
        for (var card in test) {
          selectedCardsCopy.remove(card);
        }
      } while (selectedCardsCopy.isNotEmpty && test.isNotEmpty);
    }
    if (selectedCardsCopy.isNotEmpty) {
      List<PlayCard> test;
      selectedCardsCopy.insertAll(0, selectedCards);
      do {
        List<PlayCard> oof = [];
        test = subsetEqual(selectedCardsCopy, oof, testCard.number);
        for (var card in test) {
          selectedCardsCopy.remove(card);
        }
      } while (selectedCardsCopy.isNotEmpty && test.isNotEmpty);
    }

    return selectedCardsCopy.isEmpty;
  }
}

List<PlayCard> subsetEqual(
    List<PlayCard> selected, List<PlayCard> used, int sum) {
  if (sum == 0) {
    return used;
  }

  if (sum < 0) return [];
  if (selected.isEmpty) return [];

  List<PlayCard> oof = [];
  oof.addAll(selected);
  PlayCard hold = oof.removeLast();
  List<PlayCard> test = subsetEqual(oof, used, sum);
  if (test.isNotEmpty) {
    return test;
  }

  if (hold.number == 1) {
    if (used.isEmpty)
      test = subsetEqual(oof, [hold], sum - 1);
    else {
      test = subsetEqual(oof, [...used, hold], sum - 1);
    }
  }

  if (test.isNotEmpty) {
    return test;
  }

  if (used.isEmpty)
    return subsetEqual(oof, [hold], sum - ((hold.number == 1) ? 11 : hold));
  else {
    return subsetEqual(
        oof, [...used, hold], sum - ((hold.number == 1) ? 11 : hold));
  }
}
