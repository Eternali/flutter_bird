import 'package:flutter/material.dart';

import 'package:flutter_bird/data/game_state.dart';

class FBState {

  FBState({ this.theme }) {
  }

  String theme;

  FBState copyWith({ String theme }) =>
    FBState(theme: theme ?? this.theme);

}

class FBStateObservable extends ValueNotifier<FBState> {
   FBStateObservable(FBState value) : super(value);
}
