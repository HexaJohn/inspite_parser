import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/interaction/interface.dart';
import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/story/objects/basic.dart';
import 'package:september_flutter/src/story/rooms/empty.dart';

class TutorialShipRoom extends EmptyRoom {
  @override // TODO: implement locations
  List<EntityInterface> get locations => [BasicSwitch(), BasicWindow(), BasicDoor()];
  @override
  String get title => 'Room 701';
  @override
  String get description => "A small suite aboard the starship 'TBD', bound for Du Mal.";

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
    if (inside) return Message("I'm already here");

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
  bool get inside => App.currentRoom.runtimeType == runtimeType;
}
