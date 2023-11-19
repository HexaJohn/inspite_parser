import 'package:flutter/material.dart';
import 'package:september_flutter/src/core/dictionary.dart';
import 'package:september_flutter/src/core/grammar/sentence.dart';
import 'package:september_flutter/src/core/grammar/token.dart';
import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/story/main_menu.dart';
import 'package:september_flutter/src/story/rooms/main_menu.dart';

abstract class AppInterface {
  AppInterface();

  static String get motd => 'hello';
  static List<Message> get currentContext => _currentContext;
  static StoryCrumb? get crumb => _crumb;
  static final List<Message> _currentContext = [
    Message('Welcome'),
    Message('Type something to begin'),
    Message('"Look around", "Start", "Listen for something"'),
    Message.newLine()
  ];
  static final MainMenuModule _context = MainMenuModule();
  static StoryCrumb? _crumb;
  static RoomDefinition currentRoom = MainMenuRoom();

  static void addMessage(Message input) {
    _currentContext.add(input);
  }

  static void submit(TextInteraction input) {
    // Original input
    _currentContext.add(input.toMessage());
    // Grammar tokens
    _currentContext.add(input.toTokens());
    // Token values
    _currentContext.add(input.toTokenValues());
    // distilled values
    _currentContext.add(input.toDistilled());
    // distilled index
    _currentContext.add(input.toDistilledIndex());
    // persed response
    _currentContext.add(parsePlayerInput(input, _context));
    // newline
    _currentContext.add(Message.newLine());
  }

  static Message parsePlayerInput(TextInteraction input, PointOfInterest context) {
    String? funny = Keyword.funny[input.joined];
    if (funny != null) return Message(funny, owner: '', italic: true);

    Message? special = context.evaluateSpecial(input);
    if (special != null) return special;

    Message? action = _actionParse(input, AppInterface.currentRoom);
    if (action != null) return action;

    Message? generic = _genericParse(input, context);
    if (generic != null) return generic;

    print('generic response');
    return genericResponse;
  }

  static Message? _genericParse(TextInteraction input, PointOfInterest context) {
    if (Keyword.vulgar.any((element) => input.segments.contains(element))) {
      List<String> vulgarRes = ['Highly inappropriate', 'No', 'Gross'];
      vulgarRes.shuffle();
      return Message(vulgarRes.first, owner: '');
    } else {
      return null;
    }
  }

  static Message? _actionParse(TextInteraction input, PointOfInterest context) {
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
    addMessage(Message('${room.title}: ${room.description}', bold: true, italic: true));
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

  /// Developer tool
  @protected
  Message toDistilledIndex() {
    return Message('> ${Sentence.fromString(text).ideas.first.distilled.map((e) => e?.index ?? -1)}',
        owner: '', italic: false, bold: true, fontSize: 8);
  }

  bool lookFor(List<SoftToken> tokenOrder) {
    Sentence sentence = Sentence.fromString(text);
    print('looking for ${tokenOrder} in ${sentence.asTokenValues()}');
    for (var idea in sentence.ideas) {
      print('idea match: ${_parseIdea(idea, tokenOrder)}');
      if (!_parseIdea(idea, tokenOrder)) return false;
    }
    return true;
  }

  bool _parseIdea(Idea idea, List<SoftToken> tokenOrder) {
    int r = tokenOrder.length;
    int a = 0;

    try {
      for (var token in tokenOrder) {
        print('a: $a');
        print('SOFTTOKEN: ${token.identifiers} == ${idea.distilled[a]}');
        if (token.contains(idea.distilled[a])) a++;
        print('a: $a');
        break;
      }
    } catch (e) {
      print('e257');
      // TODO
    }

    return (a == r);
  }
}

mixin InteractableMixin {
  Message? evaluateSpecial(TextInteraction input);
  Message? onInteract();
  Message? onPickup();
  Message? onActivate();
  Message? onDeactivate();
  Message? onDamage();
  Message? onObserve();
  Message? onTaste();
  Message? onListen();
  Message? onSmell();
  Message? onNothingHappened();
  Message? onEnter();
  Message? onExit();
  bool canEnter();
  bool canExit();
}

class PointOfInterest with InteractableMixin {
  PointOfInterest({this.hintText = 'An Entity', this.names = const ['thing']});
  String hintText;
  List<String> names;
  bool broken = false;

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
  Message? onSmell() {
    return null;
  }

  @override
  Message? onTaste() {
    return null;
  }
}

abstract class RoomDefinition extends PointOfInterest {
  RoomDefinition();
  List<PointOfInterest> locations = [];
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

class SoftToken {
  /// Accepts a single String, a List of Strings, or will populate identifiers
  /// with the string representation of the object that [SoftToken] is
  /// initialized with.
  SoftToken(dynamic identifier) {
    identifiers = [];
    if (identifier is List<String>) {
      identifiers = identifier.map((e) => e.toUpperCase()).toList();
    }
    if (identifier is String) {
      identifiers = [identifier.toUpperCase()];
    }
    if (identifier is Object) {
      identifiers = [identifier.toString().toUpperCase()];
    } else {
      throw UnimplementedError('Unrecognized token type');
    }
  }

  late List<String> identifiers;

  static SoftToken start() {
    return SoftToken(WeakThesarus.start);
  }

  static SoftToken game() {
    return SoftToken(['game', 'videogame', 'adventure', 'playing']);
  }

  static SoftToken pants() {
    return SoftToken(['pants', 'pantaloons', 'trousers']);
  }

  static SoftToken jacket() {
    return SoftToken(['jacket', 'coat', 'parka']);
  }

  static SoftToken shoes() {
    return SoftToken(['shoes', 'footwear', 'jays', 'sneakers', 'boots']);
  }

  static SoftToken spyglass() {
    return SoftToken(['telescope', 'spyglass', 'glass']);
  }

  bool contains(Token element) {
    return identifiers.contains(element.value);
  }

  @override
  String toString() {
    return identifiers.first;
  }
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
