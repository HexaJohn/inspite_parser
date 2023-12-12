import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/grammar/sentence.dart';
import 'package:september_flutter/src/core/grammar/token.dart';
import 'package:september_flutter/src/core/grammar/token_soft.dart';
import 'package:september_flutter/src/core/interaction/interface.dart';
import 'package:september_flutter/src/core/messages.dart';

class Entity extends EntityInterface {
  Entity({
    required String name,
    required SoftToken names,
    required String hintText,
    this.grabbable = true,
    this.weight = 1,
    Map<SoftToken, Message? Function(TextInteraction)?> specialResponses = const {},
    Message? Function(TextInteraction)? onDon,
    Message? Function(TextInteraction)? onDoff,
  }) : super(name: name, hintText: hintText, names: names, onDon: onDon, onDoff: onDoff) {
    this.specialResponses = specialResponses;
  }
  bool state = false;

  /// If true, the player can pick up the item and put it in their inventory.
  bool grabbable;

  /// The weight of the item in kilograms. If the player's inventory is too
  /// heavy, or if the player is carrying too many items, or the player isn't
  /// strong enough, the player won't be able to pick up the item.
  int weight;

  /// The size of the item in cubic centimeters. If the player's inventory is
  /// too full, the player won't be able to pick up the item. A regular sized
  /// backpack has a size of ~30L, or 30,000 cubic centimeters.
  int size = 100;

  // Message? Function(TextInteraction)? function;
}
