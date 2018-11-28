import 'package:flutter/material.dart';

enum GameStatus {
  PLAYING,
  OVER,
  START
}

class GameState {

  GameState({
    this.windowSize = const Size(1.0, 1.0),
    this.gravity = -0.15,
    this.status = GameStatus.START,
    this.speed = 0.006,
  });

  GameState copyWith({
    Size windowSize,
    double gravity,
    GameStatus status,
    double speed,
  }) => GameState(
    windowSize: windowSize ?? this.windowSize,
    gravity: gravity ?? this.gravity,
    status: status ?? this.status,
    speed: speed ?? this.speed,
  );

  Size windowSize;
  double gravity;
  GameStatus status;
  double speed;

  Offset balancedOffset(Offset pos, [ Offset parent ]) {
    parent ??= Offset(windowSize.width, windowSize.height);
    return Offset(
      (parent.dx / 2 * pos.dx) + (parent.dx / 2),
      (parent.dy / 2 * -pos.dy) + (parent.dy / 2)
    );
  }

  double bx(double x, [ double parent ]) {
    parent ??= windowSize.width;
    return (parent / 2 * x) + (parent / 2);
  }

  double by(double y, [ double parent ]) {
    parent ??= windowSize.height;
    return (parent / 2 * -y) + (parent / 2);
  }

  double regularize(double value, [ Axis axis = Axis.horizontal ]) =>
    axis == Axis.horizontal
      ? value
      : value * -1;

  Size scaleOffset(Size size, [ Size parent ]) {
    parent ??= windowSize;
    return Size(
      size.width * parent.width,
      size.height * parent.height
    );
  }

  double sw(double w) {
    assert(w.abs() <= 1.0);
    return w * windowSize.width;
  }

  double sh(double h) {
    assert(h.abs() <= 1.0);
    return h * windowSize.height;
  }

}

ValueNotifier<GameState> _gameObservable;
ValueNotifier<GameState> get gameObservable => _gameObservable;
set gameObservable(dynamic newVal) {
  if (newVal is ValueNotifier<GameState> && _gameObservable == null) {
    _gameObservable = newVal;
  } else if (newVal is GameState && _gameObservable != null) {
    _gameObservable.value = newVal;
  }
}

GameState get gs => gameObservable?.value;
