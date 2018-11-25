import 'package:flutter_bird/data/fb_state.dart';

class FBReducers {

  static FBState changeTheme(FBState oldState, String theme) => oldState.copyWith(theme: theme);

}
