import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/data/reducers.dart';

class Intents {

  static void endGame() {
    gameObservable = Reducers.changeStatus(gs, GameStatus.OVER).copyWith(score: 0);
  }

  static void startGame() {
    gameObservable = Reducers.changeStatus(gs, GameStatus.PLAYING);
  }

  static void incScore() {
    gameObservable = Reducers.incScore(gs);
  }

}
