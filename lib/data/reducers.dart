import 'package:flutter_bird/data/game_state.dart';

typedef Reducer = GameState Function();

class Reducers {

  static GameState combine(GameState origState, List<Function> reducers)

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
    if (state.highScore > state.score) return state.copyWith(highScore: state.score);
    return state;
  }

}
