import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/grammar/sentence.dart';
import 'package:september_flutter/src/core/grammar/token.dart';
import 'package:september_flutter/src/core/grammar/token_soft.dart';
import 'package:september_flutter/src/core/messages.dart';

class BasicSwitch extends PointOfInterest {
  BasicSwitch(
      {super.hintText = 'A switch of sorts', super.names = const SoftToken(['switch', 'lights']), super.name = ''});
  bool state = false;

  @override
  Message? evaluate(TextInteraction input) {
    return null;
  }
}

class BasicWindow extends PointOfInterest {
  BasicWindow(
      {super.hintText = 'Look outside!', super.names = const SoftToken(['window', 'windows']), super.name = ''});
  bool open = true;

  @override
  Message? evaluate(TextInteraction input) {
    return null;
  }
}

class BasicDoor extends PointOfInterest {
  BasicDoor(
      {super.hintText = 'Maybe I should knock?', super.names = const SoftToken(['door', 'entrance']), super.name = ''});
  bool open = false;
  bool locked = true;

  @override
  Message? evaluate(TextInteraction input) {
    return null;
  }
}

class BasicItem extends PointOfInterest {
  BasicItem(
      {super.hintText = 'A knickknack of sorts',
      super.names = const SoftToken(['item', 'thing']),
      super.name = '',
      Map<SoftToken, Message? Function(TextInteraction)?> specialResponses = const {}}) {
    this.specialResponses = specialResponses;
  }
  bool state = false;

  // Message? Function(TextInteraction)? function;

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
      Message? Function(TextInteraction)? out =
          specialResponses.entries.firstWhere((element) => element.key.contains(predicate)).value;

      if (out != null) return out(input);
    } catch (e) {
      /// If the sentence predicate doesn't match any of the special responses,
      /// return null.
      return null;
    }
  }
}

class BasicScenery extends BasicItem {
  BasicScenery(
      {super.hintText = 'A place of sorts', super.names = const SoftToken(['cliff', 'rocks']), super.name = ''});
}
