import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/data/reducers.dart';

class Intents {

  static void endGame() {
    GameState.observable.value = Reducers.changeStatus(state.value, GameStatus.OVER);
  }

  static void startGame(GameStateObservable state = GameState()) {
    state.value = Reducers.changeStatus(state.value, GameStatus.PLAYING);
  }

}
