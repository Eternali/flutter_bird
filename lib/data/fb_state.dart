import 'package:flutter/material.dart';

class FBState {

  FBState({ this.gameOver });

  bool gameOver;

  FBState copyWith({ bool gameOver }) =>
    FBState(gameOver: gameOver ?? this.gameOver);

}

class FBStateObservable extends ValueNotifier {
   FBStateObservable(FBState value) : super(value);
}
