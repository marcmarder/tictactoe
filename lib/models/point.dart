import 'dart:async';

import 'package:flutter/material.dart';
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

  Widget getWidget(Function onClick) {
    return Container(
      child: GridTile(
          child: Material(
        child: InkWell(
          onTap: onClick,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                left: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
              ),
            ),
            child: Center(
              child: Text("x: " + x.toString() + " y: " + y.toString()),
            ),
          ),
        ),
      )),
    );
  }

  @override
  BehaviorSubject<void> changeEmitter = BehaviorSubject();
}
