import 'package:flutter_bird/data/fb_state.dart';
import 'package:flutter_bird/data/fb_reducers.dart';

class Intents {

  static void changeTheme(FBStateObservable state, String theme) {
    state.value = FBReducers.changeTheme(state.value, theme);
  }

}
