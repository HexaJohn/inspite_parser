import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/story/objects/basic.dart';
import 'package:september_flutter/src/story/rooms/empty.dart';

class MLEntry1 extends EmptyRoom {
  @override // TODO: implement locations
  List<PointOfInterest> get locations => [BasicSwitch(), BasicWindow(), BasicDoor()];
  @override
  String get title => 'September 4th, 1846';
  @override
  String get description => "";

  bool lights = false;

  @override
  Message? onActivate() {
    return onNothingHappened();
  }

  @override
  Message? onDamage() {
    return Message("I'd rather not lose my security deposit", italic: true);
  }

  @override
  Message? onDeactivate() {
    return onNothingHappened();
  }

  @override
  Message? onInteract() {
    return Message('I can feel a light switch on the wall');
  }

  @override
  Message? onListen() {
    return Message(
        "Wind is howling outside while rain beats down on the window. The constant noise is broken up by cracks of thunder and the groaning of distant machinery.");
  }

  @override
  Message? onObserve() {
    if (lights) {
      return Message('$title; $description');
    } else {
      return Message("I can't see a thing with the lights off");
    }
  }

  @override
  Message? onPickup() {
    return null;
  }

  @override
  Message? onSmell() {
    return Message('I can smell coffee');
  }

  @override
  Message? onTaste() {
    return Message('Yuck! Tastes like chemicals.');
  }

  @override
  Message? onNothingHappened() {
    return null;
  }

  @override
  Message? onEnter() {
    // if (inside) return Message("I'm already here");

    AppInterface.addMessage(Message.storytelling(
        '''The sea has rested for several days now, while the sea within me rages. The storm in my heart roars at the idea I alone survived this catastrophe.

I spent quite some hours on deck staring along the horizon, blasted by the salt spray.

I have been well in light of the possibilities that surround me, although weak. Even keeping a record of my activities often exhausts me to the point of despair. More than once I have pondered whether anyone will ever review these entries, or whether I wish them to. I imagine my diary will be placed in the hands of my beloved, so she may learn what I have gone through to place it there and feel my love, for it has been more than the incredible journey we dreamed of. Truth be told, if I say not a word as the black, wretched loneliness creeps into my quarters, I may hold fast to the hope I will return to her side.

Alas, my strength wanes.
'''));

    AppInterface.setHints([
      [
        SoftToken([
          'continue',
          'next',
          'go',
          'forward',
        ])
      ],
      [
        SoftToken.start(),
        SoftToken.game(),
      ]
    ]);
    return null;
  }

  @override
  Message? onExit() {
    if (lights) {
      return Message("I'm not done here yet");
    } else {
      return Message("How am I supposed to find the exit in the dark?");
    }
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
  bool get inside => AppInterface.currentRoom.runtimeType == runtimeType;
}
