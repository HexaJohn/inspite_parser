import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/messages.dart';

class EmptyRoom extends RoomDefinition {
  List<PointOfInterest> locations = [];
  @override
  Message? evaluate(TextInteraction input) {
    return null;
  }

  @override
  String get title => 'Empty Room (Debug)';
  @override
  String get description => 'An empty room devoid of features';

  @override
  Message? onActivate() {
    return onNothingHappened();
  }

  @override
  Message? onDamage() {
    return Message("I probably shouldn't break anything here", italic: true);
  }

  @override
  Message? onDeactivate() {
    return onNothingHappened();
  }

  @override
  Message? onInteract() {
    return onNothingHappened();
  }

  @override
  Message? onListen() {
    return Message("It's very quiet here", italic: true);
  }

  @override
  Message? onObserve() {
    return Message('$title; $description', italic: true);
  }

  @override
  Message? onPickup() {
    return Message('I cannot move an entire room', italic: true);
  }

  @override
  Message? onSmell() {
    return Message('Dusty', italic: true);
  }

  @override
  Message? onTaste() {
    return Message('I do not wish to lick the room', italic: true);
  }

  @override
  Message? onNothingHappened() {
    return Message('Nothing happened', italic: true);
  }

  @override
  Message? onEnter() {
    if (inside) return Message("I'm already in here", italic: true);

    return null;
  }

  @override
  Message? onExit() {
    return null;
  }

  @override
  bool canEnter() {
    return false;
  }

  @override
  bool canExit() {
    return false;
  }

  bool get inside => App.currentRoom.runtimeType == runtimeType;
}

class TestRoom extends EmptyRoom {}
