import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/core/vulgar.dart';

abstract class WeakThesarus {
  static List<String> vulgar = vulgarStrings;
  static List<String> start = ['play', 'start', 'begin', 'initialize', 'commence', 'initiate', 'launch'];
  static List<String> interact = ['interact', 'use', 'feel', 'touch', 'flip', 'push'];
  static List<String> activate = ['activate', 'start', 'flip', 'push'];
  static List<String> deactivate = ['deactivate', 'stop'];
  static List<String> damage = ['hit', 'punch', 'kick', 'attack', 'beat', 'break', 'assault'];
  static List<String> look = ['look', 'glance', 'observe', 'watch', 'peek', 'inspect', 'scan'];
  static List<String> taste = ['lick', 'bite', 'eat', 'taste'];
  static List<String> listen = ['listen', 'hear'];
  static List<String> smell = ['smell', 'sniff', 'inhale'];
  static List<String> grab = ['grab', 'take', 'snatch', 'acquire', 'steal'];
  static List<String> enter = ['enter', 'hide', 'go', 'embark', 'open'];
  static List<String> navigate = ['get', 'go', 'move', 'walk', 'run', 'jog', 'navigate'];
  static List<String> exit = ['exit', 'leave', 'disembark', 'escape', 'close'];
  static List<String> article = ['a', 'an', 'some', 'my', 'the', 'thee', 'thine', 'this'];
  static List<String> symbols = ['!', ',', '.', '?', ';', ':', '"', "'"];
  static Map<String, String> funny = {
    'what-time-is-it': 'Time to stop asking stupid questions',
    'really': 'Yes, really',
    'hello': 'hi',
    'hi': 'hello',
    'greetings': 'salutations',
  };
}

final List<String> genericAction = ["That didn't work", "Nothing happened", "I don't think I can do that"];
List<String> genericLook = ['Not much to see here', "I can't make anything out", 'What a boring place'];
List<String> genericListen = ['The sound of silence', "I don't hear anything", 'All quiet on the western front'];
List<String> genericSmell = ['Ah yes, smells like air', "I can't smell anything", "Doesn't really smell like anything"];
List<String> genericTaste = [
  'Tastes like chicken',
  "I really don't want to taste that",
  "I'm not putting that in my mouth"
];

final List<String> refuseDamage = [
  "I'm not going to break that",
  "I probably shouldn't break that",
  "Violence isn't the answer... This time."
];
final List<String> refuseEntry = ["Would I even fit in there?", "I'm not going in there", "It's probably locked"];
final List<String> refuseExit = ["I'm definitely trapped in here", "I can't find a way out", "I can't escape"];

Message get genericResponse {
  // return Message('I must collect my thoughts', owner: '', italic: true);
  _genericResponses.shuffle();
  return Message(_genericResponses.first, owner: '', italic: true);
}

List<String> _genericResponses = [
  "What does this even mean",
  "I'm not sure how to feel about that.",
  'Please try and make some sense',
  'What is wrong with you',
  'Funny'
];
