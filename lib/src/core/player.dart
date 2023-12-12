import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/core/world/entity.dart';
import 'package:september_flutter/src/story/objects/basic.dart';

abstract class _Player {
  abstract List<Entity> inventory;
  Message? take(Entity? item);
  Message? drop(Entity? item);
}

class Player extends _Player {
  Player(this.name);
  String name;

  @override
  List<Entity> inventory = [];

  @override
  Message? take(Entity? item) {
    if (item == null) {
      return Message('I can\'t take that.');
    }
    if (inventory.contains(item)) {
      return Message('I already have that.');
    }
    inventory.add(item);
    return Message('I take the ${item.name}.');
  }

  @override
  Message? drop(Entity? item) {
    if (item == null) {
      return Message('I can\'t drop that.');
    }
    if (inventory.contains(item)) {
      return Message('I don\'t have that.');
    }
    inventory.remove(item);
    App.currentRoom.locations.add(item);
    return Message('I drop the ${item.name}.');
  }
}

class Client {
  static Player get player => App.players['client']!;
  static List<Entity> get inventory => player.inventory;
  static Message? take(Entity? item) => player.take(item);
}
