import 'package:tictactoe/models/game.dart';
import 'package:tictactoe/models/point.dart';
import 'package:tictactoe/models/state.dart';
import 'package:tictactoe/models/states/inGame.dart';

class NotStartedState implements GameState {
  NotStartedState(this.game);

  void fillGrid() {
    int currentX = 0;
    int currentY = 0;
    for (final gridPoint
        in List<int>.generate(this.game.totalGridSize, (i) => i + 1)) {
      if (currentX == this.game.wrapLineAt) {
        currentY++;
        currentX = 0;
      }
      final newPoint = Point(currentX, currentY);

      this.game.grid.add(newPoint);
      currentX++;
    }
  }

  @override
  Context game;

  @override
  void makeMove(Point point) {
    print("Start a game first");
  }

  @override
  void start() {
    print("Starting");
    this.fillGrid();
    this.game.currentState = InGameState(this.game);
    this.game.changeEmitter.add(null);
  }

  @override
  void restart() {
    print("Start a game first");
  }
}
