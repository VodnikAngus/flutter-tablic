import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tablic/main.dart';
import 'package:tablic/play_card.dart';
import 'package:tablic/player.dart';
import 'dart:math' as Math;

import 'package:tablic/screens/end_game.dart';

class CardsState with ChangeNotifier {
  CardsState() {
    reset();
    draw();
  }

  int currentPlayer;
  int lastCollected = 0;
  List<PlayCard> deck;
  List<PlayCard> playCards;
  List<PlayCard> selectedCards = [];
  List<Player> players;

  void createDeck() {
    deck = [];
    playCards = [];
    for (int i = 0; i < 4; i++) {
      if (i != 10) {
        deck.add(PlayCard(number: i + 1, suit: suits.clubs));
        deck.add(PlayCard(number: i + 1, suit: suits.diamonds));
        deck.add(PlayCard(number: i + 1, suit: suits.hearts));
        deck.add(PlayCard(number: i + 1, suit: suits.spades));
      }
    }

    deck.shuffle();
    for (var i = 0; i < 4; i++) {
      this.playCards.add(deck.removeLast());
    }
  }

  void reset() {
    createDeck();
    currentPlayer = 1;
    players = [
      Player(),
      Player(isHuman: true),
    ];

    for (var player in players) {
      player.addListener(() {
        notifyListeners();
      });
    }
  }

  void nextPlayer() async {
    do {
      currentPlayer = (currentPlayer + 1) % players.length;
      if (players[currentPlayer].cards.isEmpty && deck.isEmpty) emptyDeck();
      if (players[currentPlayer].cards.isEmpty) draw();
      if (!players[currentPlayer].isHuman) {
        await ai(currentPlayer);
      }
    } while (!players[currentPlayer].isHuman);
  }

  void emptyDeck() {
    if (playCards.isNotEmpty)
      players[lastCollected].collectedCards.addAll(playCards);
    playCards.clear();

    Player maxCards = players[0];
    for (var player in players) {
      if (player.collectedCards.length > maxCards.collectedCards.length)
        maxCards = player;
    }
    maxCards.mostCards++;
    if (endGame()) {
      if (players[0].points() > players[1].points())
        navigatorKey.currentState
            .push(MaterialPageRoute(builder: (context) => EndGame(1)));
      else if (players[0].points() < players[1].points())
        navigatorKey.currentState
            .push(MaterialPageRoute(builder: (context) => EndGame(2)));
      else
        navigatorKey.currentState
            .push(MaterialPageRoute(builder: (context) => EndGame(0)));
    }
    createDeck();
  }

  bool endGame() {
    int maxPoints = players.fold(0,
        (int max, player) => (player.points() > max) ? player.points() : max);

    return maxPoints >= 10;
  }

  void draw() {
    for (int i = 0; i < 6; i++) {
      for (Player player in players) {
        player.cards.add(deck.removeLast());
      }
    }
  }

  void toggleSelected(PlayCard card) {
    if (players[currentPlayer].isHuman) {
      if (selectedCards.contains(card))
        selectedCards.remove(card);
      else
        selectedCards.add(card);
    }
    notifyListeners();
  }

  Future<void> ai(int playerIndex) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    PlayCard maxCard;
    List<PlayCard> collectCards = [];
    int max = 0;
    int maxn = 0;
    for (var card in players[playerIndex].cards) {
      int s = 0;
      int n = 0;

      List<PlayCard> test;
      List<PlayCard> playCopy = [];
      List<PlayCard> testCards = [];
      playCopy.insertAll(0, playCards);
      if (card.number == 1) {
        do {
          List<PlayCard> oof = [];

          test = subsetEqual(playCopy, oof, 11);
          for (var testCard in test) {
            s += testCard.points();
            testCards.add(testCard);
            playCopy.remove(testCard);
          }
          n += test.length;
        } while (playCopy.isNotEmpty && test.isNotEmpty);
      } else {
        do {
          List<PlayCard> oof = [];

          test = subsetEqual(playCopy, oof, card.number);
          for (var testCard in test) {
            s += testCard.points();
            testCards.add(testCard);
            playCopy.remove(testCard);
          }
          n += test.length;
        } while (playCopy.isNotEmpty && test.isNotEmpty);
      }

      if (s > max || (s == max && n > maxn)) {
        maxCard = card;
        max = s + card.points();
        maxn = n + 1;
        collectCards.clear();
        collectCards.insertAll(0, testCards);
        lastCollected = playerIndex;
      }
    }

    maxCard ??= players[playerIndex]
        .cards[Random().nextInt(players[playerIndex].cards.length)];
    players[playerIndex].show = maxCard;
    notifyListeners();
    if (collectCards.isNotEmpty) {
      players[playerIndex].collectedCards.add(maxCard);
      selectedCards.addAll(collectCards);
    }

    await Future.delayed(
      const Duration(milliseconds: 1000),
    );

    players[playerIndex].show = null;
    players[playerIndex].cards.remove(maxCard);
    if (collectCards.isEmpty) {
      playCards.add(maxCard);
    } else {
      for (PlayCard removeCard in collectCards) {
        players[currentPlayer].collectedCards.add(removeCard);
        playCards.remove(removeCard);
      }
    }

    if (playCards.isEmpty) players[playerIndex].tables++;
    selectedCards.clear();
    notifyListeners();

    return;
  }
}
