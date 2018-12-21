import 'dart:math';

import 'package:flutter_bird/data/game_state.dart';

typedef Reducer = GameState Function(GameState);

class Reducers {

  static GameState combine(GameState origState, List<Reducer> reducers) {
    return reducers.fold(origState, (GameState state, Reducer func) => func(state));
  }

  static GameState changeStatus(GameState state, GameStatus status) {
    return state.copyWith(
      status: status
    );
  }

  static GameState incScore(GameState state) {
    return state.copyWith(
      score: state.score + 1
    );
  }

  static GameState loadHighScore(GameState state, int highScore) {
    return state.copyWith(highScore: highScore);
  }

  static GameState newHighScore(GameState state) {
    return state.copyWith(highScore: max(state.score, state.highScore));
  }

  static GameState reset(GameState state) {
    return state.copyWith(score: 0);
  }

}
