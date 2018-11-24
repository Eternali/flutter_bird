import 'package:flutter/material.dart';

import 'package:flutter_bird/data/fb_state.dart';

class Provider extends StatefulWidget {

  final FBStateObservable state;
  final Widget child;

  const Provider({ this.state, this.child, });

  static FBStateObservable of(BuildContext context) {
    _InheritedProvider ip = context.inheritFromWidgetOfExactType(_InheritedProvider);
    return ip.state;
  }

  @override
  State<StatefulWidget> createState() => _ProviderState();

}

class _ProviderState extends State<Provider> {

  didStateChange() => setState(() {  });

  @override
  initState() {
    super.initState();
    widget.state.addListener(didStateChange);
  }

  @override
  dispose() {
    widget.state.removeListener(didStateChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedProvider(
      state: widget.state,
      child: widget.child,
    );
  }

}

class _InheritedProvider extends InheritedWidget {

  final FBState _stateVal;
  final FBStateObservable state;
  final Widget child;

  _InheritedProvider({ this.state, this.child, })
    : _stateVal = state.value, super(child: child);

  @override
  bool updateShouldNotify(_InheritedProvider old) {
    return _stateVal != old._stateVal;
  }

}

