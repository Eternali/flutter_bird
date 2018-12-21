import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/data/reducers.dart';

class Intents {

  static void endGame([ GameState state ]) async {
    state ??= gs;
    if (state.score > state.highScore) {
      await saveHighScore();
    }
    gameObservable = Reducers.combine(state, [
      (s) => Reducers.changeStatus(s, GameStatus.OVER),
      (s) => Reducers.newHighScore(s)
    ]);
  }

  static void startGame([ GameState state ]) {
    state ??= gs;
    gameObservable = Reducers.combine(state, [
      (s) => Reducers.changeStatus(s, GameStatus.PLAYING),
      (s) => Reducers.reset(s)
    ]);
  }

  static void incScore([ GameState state ]) {
    state ??= gs;
    gameObservable = Reducers.incScore(state);
  }

  static void loadHighScore([ GameState state ]) async {
    state ??= gs;
    final file = await getApplicationDocumentsDirectory().then((dir) => File('${dir.path}/state.json'));
    String read = await file.readAsString();
    if (read.length <= 0) {
      read = jsonEncode({ 'highScore': 0 });
      await file.writeAsString(read);
    }
    gameObservable = Reducers.loadHighScore(state, jsonDecode(read)['highScore'] ?? 0);
  }

  static Future saveHighScore([ GameState state ]) async {
    state ??= gs;
    final file = await getApplicationDocumentsDirectory().then((dir) => File('${dir.path}/state.json'));
    await file.writeAsString(jsonEncode({ 'highScore': state.highScore }));
  }

}
