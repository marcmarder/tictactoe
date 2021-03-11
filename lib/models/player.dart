import 'package:flutter/material.dart';

enum Char { x, o }

class Player {
  Char char;
  Color color;
  Player(this.char, this.color);

  String get displayName {
    String newtext = char.toString().split(".")[1];
    return newtext;
  }

  Widget getWidget() {
    return GridTile(
        child: Container(
            color: this.color,
            // height: 10,
            // width: 10,
            child: Center(
                child: Text(
              displayName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 64,
              ),
            ))));
  }
}
