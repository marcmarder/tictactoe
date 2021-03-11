import 'dart:async';

import 'package:tictactoe/models/game.dart';
import 'package:tictactoe/models/player.dart';
import 'package:tictactoe/models/point.dart';
import 'package:tictactoe/models/state.dart';
import 'package:tictactoe/models/states/notStarted.dart';

class InGameState implements GameState {
  @override
  Context game;

  InGameState(this.game);

  void setWinner(Player winner) {
    this.game.winner = winner;
    print(winner.displayName + "hat gewonnen");
    this.game.changeEmitter.add(null);

    Timer(Duration(seconds: 5), () {
      if (this.game.currentState == NotStartedState(this.game)) {
        this.restart();
      }
    });
  }

  Player checkDiagonal() {
    // oben links -> unten rechts
    Player hitPlayer;
    int pointHit = 0;
    for (final iter in List<int>.generate(this.game.wrapLineAt, (i) => i + 1)) {
      Point point = this.game.grid.firstWhere(
          (element) => element.x == iter && element.y == iter,
          orElse: () => null);
      if (point == null) {
        return null;
      }
      if (hitPlayer == null) {
        hitPlayer = point.player;
      }
      if (point.player == hitPlayer) {
        pointHit++;
      } else {
        return null;
      }
      if (pointHit == this.game.wrapLineAt) {
        return hitPlayer;
      }
    }
    return null;
  }

  Player checkHorizontal() {
    bool checkOcccurence(Point point, Player player) {
      final occurenceX = this
          .game
          .grid
          .where((p) => point.x == p.x && p.player == player)
          .toList()
          .length;
      if (occurenceX == this.game.wrapLineAt) {
        return true;
      }
      final occurenceY = this
          .game
          .grid
          .where((p) => point.y == p.y && p.player == player)
          .toList()
          .length;
      if (occurenceY == (this.game.totalGridSize / this.game.wrapLineAt)) {
        return true;
      }
      return false;
    }

    for (final point in this.game.grid) {
      if (checkOcccurence(point, this.game.x)) {
        return this.game.x;
      }
      if (checkOcccurence(point, this.game.o)) {
        return this.game.o;
      }
    }
  }

  void checkWon() {
    final diagnoalResult = checkDiagonal();
    if (diagnoalResult != null) {
      this.setWinner(diagnoalResult);
      return;
    }

    final horizontalResult = checkHorizontal();
    if (horizontalResult != null) {
      this.setWinner(horizontalResult);
      return;
    }
  }

  @override
  void makeMove(Point point) {
    print("Making move");
    print("Update: " + point.x.toString() + ", " + point.y.toString());
    point.setPlayer(this.game.currentPlayer);

    if (this.game.currentPlayer == this.game.x) {
      this.game.currentPlayer = this.game.o;
    } else if (this.game.currentPlayer == this.game.o) {
      this.game.currentPlayer = this.game.x;
    }
    this.game.changeEmitter.add(null);
    this.checkWon();
  }

  @override
  void start() {
    print("Cannot Start, because game is running");
  }

  @override
  void restart() {
    print("Restarting");
    this.game.reset();
    this.game.currentState = NotStartedState(this.game);
    this.game.currentState.start();
    this.game.changeEmitter.add(null);
  }
}
