import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/data/reducers.dart';

class Intents {

  static void endGame() {
    gameObservable = Reducers.changeStatus(gameObservable.value, GameStatus.OVER);
  }

  static void startGame() {
    gameObservable = Reducers.changeStatus(gameObservable.value, GameStatus.PLAYING);
  }

}
