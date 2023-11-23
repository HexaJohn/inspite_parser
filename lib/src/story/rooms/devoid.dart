import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/messages.dart';

class VoidRoom extends RoomDefinition {
  @override
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
    return onNothingHappened();
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
    return onNothingHappened();
  }

  @override
  Message? onObserve() {
    return onNothingHappened();
  }

  @override
  Message? onPickup() {
    return onNothingHappened();
  }

  @override
  Message? onSmell() {
    return onNothingHappened();
  }

  @override
  Message? onTaste() {
    return onNothingHappened();
  }

  @override
  Message? onNothingHappened() {
    return null;
  }

  @override
  Message? onEnter() {
    return onNothingHappened();
  }

  @override
  Message? onExit() {
    return onNothingHappened();
  }

  @override
  bool canEnter() {
    return false;
  }

  @override
  bool canExit() {
    return false;
  }

  String get subdefinitions => locations.map((e) => e.hintText).join(' ');

  bool get inside => AppInterface.currentRoom.runtimeType == runtimeType;
}
