import 'package:flutter_bird/data/game_state.dart';

class Reducers {

  static GameState changeStatus(GameState state, GameStatus status) {
    state.copyWith(
      status: status
    );
    return GameState();
  }

}
