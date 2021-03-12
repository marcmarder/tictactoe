import 'package:flutter/material.dart';
import 'package:tictactoe/models/game.dart';
import 'package:tictactoe/models/point.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Context game;
  @override
  void initState() {
    this.game = Context();
    this.game.currentState.start();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TicTacToe"),
      ),
      body: Center(
        child: StreamBuilder<Object>(
            stream: this.game.changeEmitter,
            builder: (context, snapshot) {
              if (this.game.winner == null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: GridView.count(
                          crossAxisCount: this.game.wrapLineAt,
                          childAspectRatio: 1.0,
                          padding: const EdgeInsets.all(4.0),
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          children:
                              <Point>[...this.game.grid].map((Point point) {
                            return StreamBuilder<void>(
                                stream: point.changeEmitter,
                                builder: (context, snapshot) {
                                  if (point.player == null) {
                                    return Container(
                                      child: GridTile(
                                          child: Material(
                                        child: InkWell(
                                          onTap: () {
                                            this
                                                .game
                                                .currentState
                                                .makeMove(point);
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    width: 1.0,
                                                    color: Color(0xFFFFFFFFFF)),
                                                left: BorderSide(
                                                    width: 1.0,
                                                    color: Color(0xFFFFFFFFFF)),
                                                right: BorderSide(
                                                    width: 1.0,
                                                    color: Color(0xFFFF000000)),
                                                bottom: BorderSide(
                                                    width: 1.0,
                                                    color: Color(0xFFFF000000)),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text("x: " +
                                                  point.x.toString() +
                                                  " y: " +
                                                  point.y.toString()),
                                            ),
                                          ),
                                        ),
                                        color: Colors.white,
                                      )),
                                    );
                                  }
                                  return point.player.getWidget();
                                });
                          }).toList()),
                    ),
                  ],
                );
              } else {
                return Container(
                  color: this.game.winner.color,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        this.game.winner.displayName + " hat Gewonnen!",
                        style: TextStyle(fontSize: 40),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this.game.currentState.restart();
        },
        tooltip: 'Reset',
        child: Icon(Icons.refresh_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
