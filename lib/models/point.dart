import 'package:rxdart/rxdart.dart';
import 'package:tictactoe/models/changeEmitter.dart';
import 'package:tictactoe/models/player.dart';

class Point implements ChangeEmitter {
  int x;
  int y;
  Point(this.x, this.y);
  Player player;

  void setPlayer(Player newPlayer) {
    if (this.player == null) {
      this.player = newPlayer;
    }
    this.changeEmitter.add(null);
  }

  @override
  BehaviorSubject<void> changeEmitter = BehaviorSubject();
}
