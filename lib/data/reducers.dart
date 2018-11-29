import 'package:flutter_bird/data/game_state.dart';

class Reducers {

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

}
