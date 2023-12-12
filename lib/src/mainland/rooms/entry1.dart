import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/grammar/token_soft.dart';
import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/mainland/rooms/cliff.dart';
import 'package:september_flutter/src/story/objects/basic.dart';
import 'package:september_flutter/src/story/rooms/devoid.dart';

class MLEntry1 extends VoidRoom {
  MLEntry1() {
    super.name = 'entry1';
    locations = [];
  }
  @override
  String get title => 'September 4th, 1846';
  @override
  String get description => "";

  bool lights = false;

  @override
  Message? evaluateSpecial(TextInteraction input) {
    print('evaluating special for entry1');
    if (input.lookFor([SoftToken.next()])) {
      return onExit();
    }
    return null;
  }

  @override
  Message? onEnter() {
    App.clearHints();
    // if (inside) return Message("I'm already here");

    App.addMessage(Message.storytelling(
        '''The sea has rested for several days now, while the sea within me rages. The storm in my heart roars at the idea I alone survived this catastrophe.

I spent quite some hours on deck staring along the horizon, blasted by the salt spray.

I have been well in light of the possibilities that surround me, although weak. Even keeping a record of my activities often exhausts me to the point of despair. More than once I have pondered whether anyone will ever review these entries, or whether I wish them to. I imagine my diary will be placed in the hands of my beloved, so she may learn what I have gone through to place it there and feel my love, for it has been more than the incredible journey we dreamed of. Truth be told, if I say not a word as the black, wretched loneliness creeps into my quarters, I may hold fast to the hope I will return to her side.

Alas, my strength wanes.
'''));

    App.setHints([
      [SoftToken.next()],
    ]);
    return null;
  }

  @override
  Message? onNothingHappened() {
    return Message('I must collect my thoughts');
  }

  @override
  Message? onExit() {
    App.changeContext(MLCliff());
    return Message.invisible();
  }

  @override
  bool canEnter() {
    return false;
  }

  @override
  bool canExit() {
    return false;
  }

  @override
  bool get inside => App.currentRoom.runtimeType == runtimeType;
}
