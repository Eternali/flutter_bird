import 'package:flutter_bird/data/fb_state.dart';

class Reducers {

  static FBState changeTheme(FBState oldState, String theme) => oldState.copyWith(theme: theme);

}
