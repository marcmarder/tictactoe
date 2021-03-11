import 'package:tictactoe/models/game.dart';
import 'package:tictactoe/models/point.dart';

abstract class GameState {
  Context game;
  GameState(this.game);
  void makeMove(Point point);
  void start();
  void restart();
}
