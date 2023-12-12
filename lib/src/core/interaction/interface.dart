import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/grammar/sentence.dart';
import 'package:september_flutter/src/core/grammar/token.dart';
import 'package:september_flutter/src/core/grammar/token_soft.dart';
import 'package:september_flutter/src/core/interaction/enterable.dart';
import 'package:september_flutter/src/core/interaction/functional.dart';
import 'package:september_flutter/src/core/interaction/grabbable.dart';
import 'package:september_flutter/src/core/interaction/interactable.dart';
import 'package:september_flutter/src/core/interaction/sensible.dart';
import 'package:september_flutter/src/core/interaction/washable.dart';
import 'package:september_flutter/src/core/interaction/wearable.dart';
import 'package:september_flutter/src/core/messages.dart';

abstract class EntityInterface
    with
        InteractableMixin,
        EnterableMixin,
        FunctionalMixin,
        GrabbableMixin,
        SensibleMixin,
        WashableMixin,
        WearableMixin {
  EntityInterface({
    this.hintText = 'An Entity',
    this.names = const SoftToken(['thing']),
    required this.name,
    this.onDon,
    this.onDoff,
  });
  String hintText;
  String name;
  SoftToken names;
  bool broken = false;
  Map<SoftToken, Message? Function(TextInteraction)?> specialResponses = {};

  late final Map<SoftToken, Message? Function(TextInteraction)?> standardResponses = {
    const SoftToken(['drop', 'discard', 'trash', 'throw away']): (TextInteraction input) {
      return onDrop();
    },
    const SoftToken(['pick up', 'grab', 'take', 'acquire', 'withdraw']): (TextInteraction input) {
      return onPickup();
    },
    const SoftToken(['put on', 'don', 'wear']): (TextInteraction input) {
      print('eval for don');
      return _functionOrNull(onDon, input);
    },
    const SoftToken(['remove', 'take off', 'doff']): (TextInteraction input) {
      print('eval for doff');
      return _functionOrNull(onDoff, input);
    },
    const SoftToken(['get in', 'enter', 'go in', 'get in', 'get on']): (TextInteraction input) {
      return onEnter();
    },
    const SoftToken(['get out', 'exit', 'get out', 'get off', 'leave']): (TextInteraction input) {
      return onExit();
    },
    const SoftToken(['activate', 'switch on', 'start']): (TextInteraction input) {
      return onActivate();
    },
    const SoftToken(['deactivate', 'switch off', 'stop']): (TextInteraction input) {
      return onDeactivate();
    },
    const SoftToken(['break', 'attack', 'smash', 'hit', 'punch']): (TextInteraction input) {
      return onDamage();
    },
    const SoftToken(['listen', 'listen to', 'hear']): (TextInteraction input) {
      return onListen();
    },
    const SoftToken(['smell', 'sniff', 'inhale']): (TextInteraction input) {
      return onSmell();
    },
    const SoftToken(['taste', 'lick', 'eat']): (TextInteraction input) {
      return onTaste();
    },
    const SoftToken(['clean', 'wash', 'wipe']): (TextInteraction input) {
      return onWash();
    },
  };

  Message? _functionOrNull(Message? Function(TextInteraction)? function, TextInteraction input) {
    return function == null ? null : function(input);
  }

  @override
  Message? evaluate(TextInteraction input) {
    // print('evaluating ${input.toDistilledTokens()} [${input.raw}] on $name');
    final Idea sentence = input.toSentence().ideas.first;
    // print('evaluating sentence ${sentence} [${input.raw}] on $name');
    final Token? predicate = sentence.predicate;
    // print('evaluating predicate ${predicate} [${input.raw}] on $name');
    final Token? directObject = sentence.directObject;
    // print('evaluating subject ${subject} [${input.raw}] on $name');

    /// If the sentence doesn't have a predicate, return null.
    if (predicate == null) return null;

    /// If the sentence doesn't have a subject, return null.
    if (directObject == null) return null;

    /// Use the sentence subject to determine if the player is talking about
    /// this item. If not, return null.
    if (!names.contains(directObject)) {
      return null;
    }

    /// Look for a special response that matches the sentence predicate. If
    /// there is one, invoke it and return the result.
    try {
      Message? Function(TextInteraction)? special;
      try {
        special = specialResponses.entries.firstWhere((element) => element.key.contains(predicate)).value;
        print('special output: $special');
      } catch (e) {
        // TODO
      }

      Message? Function(TextInteraction)? standard;
      try {
        standard = standardResponses.entries.firstWhere((element) => element.key.contains(predicate)).value;
        print('standard output: $standard');
      } catch (e) {
        // TODO
      }

      if (special != null) return special(input);
      if (standard != null) return standard(input);
      print(this.toString() + ' has no response for ' + predicate.toString());
      return null;
    } catch (e) {
      /// If the sentence predicate doesn't match any of the special responses,
      /// return null.
      print('failed to match predicate $predicate? because $e');
      return null;
    }
  }

  @override
  Message? evaluateSpecial(TextInteraction input) {
    // TODO: implement special
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

  @override
  Message? onActivate() {
    return null;
  }

  @override
  Message? onDamage() {
    return null;
  }

  @override
  Message? onDeactivate() {
    return null;
  }

  @override
  Message? onEnter() {
    return null;
  }

  @override
  Message? onExit() {
    return null;
  }

  @override
  Message? onInteract() {
    return null;
  }

  @override
  Message? onListen() {
    return null;
  }

  @override
  Message? onNothingHappened() {
    return null;
  }

  @override
  Message? onObserve() {
    return null;
  }

  @override
  Message? onPickup() {
    return null;
  }

  @override
  Message? onDrop() {
    return null;
  }

  @override
  Message? onSmell() {
    return null;
  }

  @override
  Message? onTaste() {
    return null;
  }

  @override
  Message? onWash() {
    return null;
  }

  @override
  Message? Function(TextInteraction)? onDon = (p0) => null;

  @override
  Message? Function(TextInteraction)? onDoff = (p0) => null;
}
