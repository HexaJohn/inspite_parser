import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/story/objects/basic.dart';

abstract class Player {
  static List<BasicItem> inventory = [];
  static Message? take(BasicItem item) {
    if (inventory.contains(item)) {
      return Message('I already have that.');
    }
    inventory.add(item);
    return Message('I take the ${item.name}.');
  }
}
