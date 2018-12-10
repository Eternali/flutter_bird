import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/data/reducers.dart';

class Intents {

  static void endGame([ GameState state ]) {
    state ??= gs;
    if (state.score > state.highScore) {
      // gameObservable = Reducers.newHighScore(state);
      saveHighScore();
      // debugPrint(gs.highScore.toString());
    }
    gameObservable = Reducers.changeStatus(state, GameStatus.OVER).copyWith(score: 0, highScore: state.score > state.highScore ? state.score : state.highScore);
  }

  static void startGame([ GameState state ]) {
    state ??= gs;
    gameObservable = Reducers.changeStatus(state, GameStatus.PLAYING);
  }

  static void incScore([ GameState state ]) {
    state ??= gs;
    gameObservable = Reducers.incScore(state);
  }

  static void loadHighScore([ GameState state ]) async {
    state ??= gs;
    final file = await getApplicationDocumentsDirectory().then((dir) => File('${dir.path}/state.json')..create());
    String read = await file.readAsString();
    if (read.length <= 0) {
      read = jsonEncode({ 'highScore': 0 });
      await file.writeAsString(read);
    }
    gameObservable = Reducers.loadHighScore(state, jsonDecode(read)['highScore'] ?? 0);
  }

  static void saveHighScore([ GameState state ]) async {
    state ??= gs;
    final file = await getApplicationDocumentsDirectory().then((dir) => File('${dir.path}/state.json')..create());
    await file.writeAsString(jsonEncode({ 'highScore': state.highScore }));
  }

}
