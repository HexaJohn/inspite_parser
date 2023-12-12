import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/interaction/interface.dart';
import 'package:september_flutter/src/core/messages.dart';

class MainMenuRoom extends RoomDefinition {
  MainMenuRoom({super.name = 'mainMenuRoom'});

  @override
  String get title => 'Main Menu';
  @override
  String get description => 'Start and quit the game';

  @override
  Message? evaluate(TextInteraction input) {
    return null;
  }

  @override
  Message? onActivate() {
    return onNothingHappened();
  }

  @override
  Message? onDamage() {
    return Message("How am I supposed to break a menu", italic: true);
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
    return Message("That's a pretty cool theme song", italic: true);
  }

  @override
  Message? onObserve() {
    return Message('$title; $description', italic: true);
  }

  @override
  Message? onPickup() {
    return Message('This menu exists beyond space and time. And I do not want it', italic: true);
  }

  @override
  Message? onSmell() {
    return Message('Smells like text', italic: true);
  }

  @override
  Message? onTaste() {
    return Message('Delicious!', italic: true);
  }

  @override
  Message? onNothingHappened() {
    return null;
  }

  @override
  Message? onEnter() {
    if (inside) return Message("I'm already here", italic: true);

    return null;
  }

  @override
  Message? onExit() {
    return Message("Quitting game...", italic: true);
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

  @override
  List<EntityInterface> locations = [];
}
