import 'package:flutter/material.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';
import 'package:tictactoe/models/changeEmitter.dart';
import 'package:tictactoe/models/player.dart';
import 'package:tictactoe/models/point.dart';
import 'package:tictactoe/models/state.dart';
import 'package:tictactoe/models/states/notStarted.dart';

class Context implements ChangeEmitter {
  List<Point> grid = [];
  GameState currentState;
  Player x = Player(Char.x, Colors.green);
  Player o = Player(Char.o, Colors.pink);
  Player currentPlayer;
  int wrapLineAt = 3; // 3

  int get totalGridSize {
    return wrapLineAt * wrapLineAt;
  }

  Player winner;

  Context() {
    this.reset();
    currentState = NotStartedState(this);
  }

  void reset() {
    this.currentPlayer = this.x;
    this.winner = null;
    this.grid = [];
  }

  @override
  BehaviorSubject<void> changeEmitter = BehaviorSubject();
}
