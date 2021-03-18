import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController gridEditingController = TextEditingController();
  @override
  void initState() {
    this.game = Context();
    this.gridEditingController.text = this.game.wrapLineAt.toString();
    this.game.currentState.start();
    super.initState();
  }

  @override
  void dispose() {
    this.gridEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TicTacToe"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: StreamBuilder<Object>(
            stream: this.game.changeEmitter,
            builder: (context, snapshot) {
              if (this.game.draw) {
                return Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Unentschieden!",
                        style: TextStyle(fontSize: 40),
                      ),
                    ],
                  ),
                );
              }
              if (this.game.winner == null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: GridView.count(
                          crossAxisCount: this.game.wrapLineAt,
                          childAspectRatio: 1,
                          mainAxisSpacing: 1.0,
                          crossAxisSpacing: 1.0,
                          children:
                              <Point>[...this.game.grid].map((Point point) {
                            return StreamBuilder<void>(
                                stream: point.changeEmitter,
                                builder: (context, snapshot) {
                                  if (point.player == null) {
                                    return point.getWidget(() => {
                                          this.game.currentState.makeMove(point)
                                        });
                                  }
                                  return point.player.getWidget();
                                });
                          }).toList()),
                    ),
                    TextField(
                      controller: gridEditingController,
                      decoration: InputDecoration(labelText: "Gridsize"),
                      onSubmitted: (val) {
                        if (val.length == 0) {
                          return;
                        }
                        try {
                          final newInt = int.parse(val);
                          if (newInt > 20) {
                            return;
                          }
                          setState(() {
                            this.game.wrapLineAt = newInt;
                            this.game.currentState.restart();
                          });
                        } catch (e) {}
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
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
