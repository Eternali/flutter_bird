# flutter_bird

A flutter project for getting to know how to use spritewidget to build games with flutter!

## Notes to remember:

Be careful using things like Redux, InheritedWidgets, and really anything that can potentially rebuild your game widget when you don't want it to.
For example, if you are using an InheritedWidget to share a global state that automatically rebuilds dependant widgets (like fb_state),
if your game widget depends on the state, it will be rebuilt on a state change, which essentially means it will restart (save anything persisted in
storage or in a singleton (like game_state)).

All this is to say, keep your game state in a separate, context independant, singleton, and the rest of your app state somewhere else.
This all might sound pretty obvious and simple, but if you have standard flutter widgets that are rendered depending on the state of your game, and/or
if you want to manipulate your game state from these standard flutter widgets, this becomes an issue. For example, say I have a "PLAY" RaisedButton
(a "standard" flutter widget) and I want it to set the game status to "PLAYING" when pressed. I also want this button to disappear when playing the game.
Since I want to modify and access this game status variable from both standard flutter widgets and from within nodes in my game widget, I can't store
it in my app state because that would mean the game would "Restart" anytime I modify it, which I don't want. And I can't store it in my game state
either because then when I modify it, the "PLAY" button wouldn't be updated.
What is the answer? One solution would be to create a type of InheritedWidget in which the user could choose which widgets in the dependancy graph
to update depending on the changes to the app state.

The workaround/current solution I have is to simply add a game state observable, through which all modifications to the game state singleton are made.
Widgets outside of the game that want to be updated when the game state changes can subscribe to the observable. Although this works fine, I think this
situation is a perfect example to highlight the need for a conditional updating of dependand widgets feature to be added to redux libraries,
InheritedWidgets and the like.

I don't doubt something like this already exists somewhere, I just haven't found it yet.
