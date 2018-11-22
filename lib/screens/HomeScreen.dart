import 'package:flutter/material.dart';

import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/game_widget.dart';

class HomeScreen extends StatefulWidget {

  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  GameState _state;

  @override
  Widget build(BuildContext context) {
    _state = GameState(windowSize: MediaQuery.of(context).size);

    return Scaffold(
      body: GameWidget(),
    );
  }

}
