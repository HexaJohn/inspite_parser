import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:september_flutter/src/core/dictionary.dart';
import 'package:september_flutter/src/core/grammar/sentence.dart';
import 'package:september_flutter/src/core/grammar/token.dart';
import 'package:september_flutter/src/core/grammar/token_soft.dart';
import 'package:september_flutter/src/core/interaction/enterable.dart';
import 'package:september_flutter/src/core/interaction/functional.dart';
import 'package:september_flutter/src/core/interaction/grabbable.dart';
import 'package:september_flutter/src/core/interaction/interactable.dart';
import 'package:september_flutter/src/core/interaction/interface.dart';
import 'package:september_flutter/src/core/interaction/sensible.dart';
import 'package:september_flutter/src/core/interaction/washable.dart';
import 'package:september_flutter/src/core/interaction/wearable.dart';
import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/core/player.dart';
import 'package:september_flutter/src/story/main_menu.dart';
import 'package:september_flutter/src/story/rooms/main_menu.dart';

abstract class App {
  App();

  static String get motd => 'hello';
  static Map<String, Player> get players => _players;
  static Map<String, Player> _players = {};
  static Player get client => _players['client']!;
  static List<Message> get currentContext => _currentContext;
  static List<Sentence> get playerInputs => _inputs;
  static StoryCrumb? get crumb => _crumb;
  static String get location => currentRoom.identifier;
  static final List<Message> _currentContext = [
    Message('Welcome'),
    Message('Type something to begin'),
    Message('"Look around", "Start", "Listen for something"'),
    Message.newLine()
  ];
  static final List<Sentence> _inputs = [];
  static StoryCrumb? _crumb;
  static RoomDefinition currentRoom = MainMenuModule();
  static List<List<SoftToken>> hints = [];

  static void addMessage(Message? input) {
    if (input == null) return;
    if (input.value == '######') return;
    if (input.value == '> DEBUG') {
      print('debugger');
      debugger();
    }
    _currentContext.add(input);
    // _currentContext.add(Message.newLine());
  }

  static void submit(TextInteraction input) {
    // Original input
    addMessage(input.toMessage());
    _inputs.add(input.toSentence());
    // Grammar tokens
    // addMessage(input.toTokens());
    // Token values
    // addMessage(input.toTokenValues());
    // distilled values
    // addMessage(input.toDistilled());
    // distilled index
    // addMessage(input.toDistilledIndex());
    // persed response
    addMessage(parsePlayerInput(input, currentRoom));
    // newline
    addMessage(Message.newLine());
  }

  static Message parsePlayerInput(TextInteraction input, EntityInterface context) {
    String? funny = Keyword.funny[input.joined];
    if (funny != null) return Message(funny, owner: '', italic: true);

    Message? simple = context.evaluate(input);
    if (simple != null) return simple;

    Message? special = context.evaluateSpecial(input);
    if (special != null) return special;

    Message? action = _actionParse(input, App.currentRoom);
    if (action != null) return action;

    Message? generic = _genericParse(input, context);
    if (generic != null) return generic;

    print('generic response from ${context.name}');
    return genericResponse;
  }

  static Message? _genericParse(TextInteraction input, EntityInterface context) {
    if (Keyword.vulgar.any((element) => input.segments.contains(element))) {
      List<String> vulgarRes = ['Highly inappropriate', 'No', 'Gross'];
      vulgarRes.shuffle();
      return Message(vulgarRes.first, owner: '');
    } else {
      return null;
    }
  }

  static Message? _actionParse(TextInteraction input, EntityInterface context) {
    if (WeakThesarus.interact.any((element) => input.segments.contains(element))) {
      genericAction.shuffle();
      Message? result = context.onInteract();
      if (result != null) return result;
      return Message(genericAction.first, owner: '');
    }
    if (WeakThesarus.grab.any((element) => input.segments.contains(element))) {
      genericAction.shuffle();
      Message? result = context.onPickup();
      if (result != null) return result;
      return Message(genericAction.first, owner: '');
    }

    if (WeakThesarus.activate.any((element) => input.segments.contains(element))) {
      genericAction.shuffle();
      Message? result = context.onActivate();
      if (result != null) return result;
      return Message(genericAction.first, owner: '');
    }
    if (WeakThesarus.deactivate.any((element) => input.segments.contains(element))) {
      genericAction.shuffle();
      Message? result = context.onDeactivate();
      if (result != null) return result;
      return Message(genericAction.first, owner: '');
    }
    if (WeakThesarus.damage.any((element) => input.segments.contains(element))) {
      refuseDamage.shuffle();
      Message? result = context.onDamage();
      if (result != null) return result;
      return Message(refuseDamage.first, owner: '');
    }

    if (WeakThesarus.look.any((element) => input.segments.contains(element))) {
      genericLook.shuffle();
      Message? result = context.onObserve();
      if (result != null) return result;
      return Message(genericLook.first, owner: '');
    }
    if (WeakThesarus.taste.any((element) => input.segments.contains(element))) {
      genericTaste.shuffle();
      Message? result = context.onTaste();
      if (result != null) return result;
      return Message(genericTaste.first, owner: '');
    }
    if (WeakThesarus.listen.any((element) => input.segments.contains(element))) {
      genericListen.shuffle();
      Message? result = context.onListen();
      if (result != null) return result;
      return Message(genericListen.first, owner: '');
    }
    if (WeakThesarus.smell.any((element) => input.segments.contains(element))) {
      genericSmell.shuffle();
      Message? result = context.onSmell();
      if (result != null) return result;
      return Message(genericSmell.first, owner: '');
    }
    if (WeakThesarus.enter.any((element) => input.segments.contains(element))) {
      refuseEntry.shuffle();
      Message? result = context.onEnter();
      if (result != null) return result;
      return Message(refuseEntry.first, owner: '');
    }
    if (WeakThesarus.exit.any((element) => input.segments.contains(element))) {
      refuseExit.shuffle();
      Message? result = context.onExit();
      if (result != null) return result;
      return Message(refuseExit.first, owner: '');
    }

    return null;
  }

  static void setCrumb(StoryCrumb crumb) {
    _crumb = crumb;
  }

  static void clearCrumb() {
    _crumb = null;
  }

  static void newGame() {
    // currentRoom = TutorialShipRoom();
  }

  static void loadGame() {
    clearCrumb();
  }

  static void changeContext(RoomDefinition room) {
    clearCrumb();

    currentRoom = room;
    currentContext.clear();
    // addMessage(Message('${room.title}: ${room.description}', bold: true, italic: true));
    addMessage(room.onEnter());
  }

  static void setHints(List<List<SoftToken>> list) {
    hints = list;
  }

  static void clearHints() {
    hints.clear();
  }

  static void addPlayer(String s) {
    _players.putIfAbsent(s, () => Player(s));
  }
}

class TextInteraction {
  TextInteraction(this.text);
  String text;

  List<String> get segments {
    String clean = cleanupSymbols(text);
    return clean.toLowerCase().split(' ');
  }

  List<String> get raw {
    final List<String> segs = List.from(segments);
    segs.removeWhere((element) => Keyword.article.contains(element));
    for (var element in segs) {
      element = cleanupSymbols(element);
    }
    // seg.removeWhere((element) => Keyword.symbols.contains(element));
    return segs;
  }

  String cleanupSymbols(String element) {
    String original = element;
    element = element.replaceAll('?', '');
    element = element.replaceAll('!', '');
    element = element.replaceAll('.', '');
    element = element.replaceAll(',', '');
    element = element.replaceAll(';', '');
    element = element.replaceAll(':', '');
    element = element.replaceAll("'", '');
    element = element.replaceAll('"', '');
    element = element.replaceAll('~', '');
    return element;
  }

  get joined => cleanupSymbols(raw.join('-'));

  Sentence toSentence() {
    return Sentence.fromString(text);
  }

  Message toMessage() {
    return Message('> $text', owner: '', italic: false, bold: true);
  }

  /// Developer tool
  @protected
  Message toTokens() {
    return Message('> ${Sentence.fromString(text).asTokens()}', owner: '', italic: false, bold: true, fontSize: 8);
  }

  /// Developer tool
  @protected
  Message toTokenValues() {
    return Message('> ${Sentence.fromString(text).asTokenValues()}', owner: '', italic: false, bold: true, fontSize: 8);
  }

  /// Developer tool
  @protected
  Message toDistilled() {
    return Message('> ${Sentence.fromString(text).ideas.first.distilled}',
        owner: '', italic: false, bold: true, fontSize: 8);
  }

  List<Token> toDistilledTokens() {
    return Sentence.fromString(text).ideas.first.distilled;
  }

  /// Developer tool
  @protected
  Message toDistilledIndex() {
    return Message('> ${Sentence.fromString(text).ideas.first.distilled.map((e) => e?.index ?? -1)}',
        owner: '', italic: false, bold: true, fontSize: 8);
  }

  bool lookFor(List<SoftToken> tokenOrder) {
    Sentence sentence = Sentence.fromString(text);
    // print('looking for ${tokenOrder} in ${sentence.asTokenValues()}');
    for (var idea in sentence.ideas) {
      // print('idea match: ${_parseIdea(idea, tokenOrder)}');
      if (!_parseIdea(idea, tokenOrder)) return false;
    }
    return true;
  }

  bool _parseIdea(Idea idea, List<SoftToken> tokenOrder) {
    int r = tokenOrder.length;
    int a = 0;

    try {
      for (var token in tokenOrder) {
        // print('a: $a');
        // print('SOFTTOKEN: ${token.identifiers} == ${idea.distilled[a]}');
        if (token.contains(idea.distilled[a])) a++;
        // print('a: $a');
        break;
      }
    } catch (e) {
      print('e257');
      // TODO
    }

    return (a == r);
  }
}

abstract class RoomDefinition extends EntityInterface {
  RoomDefinition({required super.name});
  abstract List<EntityInterface> locations;
  String get identifier => 'room';
  String get title => 'Abstract Room';
  String get description => 'A room';
}

class StoryNode {
  StoryNode(this.responses);
  Map<KeywordChain, Message> responses;
}

class KeywordChain {
  KeywordChain(this.chain);
  List<Keyword> chain;
}

class Keyword {
  Keyword(this.map);
  Map<String, List<String>> map;

  static List<String> vulgar = WeakThesarus.vulgar;
  static List<String> start = WeakThesarus.start;
  static List<String> article = WeakThesarus.article;
  static Map<String, String> funny = WeakThesarus.funny;
}

class StoryCrumb {
  StoryCrumb(this.lookingFor, Null Function() param1);
  List<String> lookingFor;
}

enum NounEntity {
  person,
  place,
  thing,
  idea,
}

enum GameStates {
  mainMenu,
  tutorial0,
  tutorial1,
  tutorial2,
}
