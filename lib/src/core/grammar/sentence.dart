import 'package:september_flutter/src/core/grammar/token.dart';

/// https://www.butte.edu/departments/cas/tipsheets/grammar/sentence_structure.html
class Idea {
  Idea({this.index = 0});
  List<Token> tokens = [];
  int index;

  /// A sentence fragment is a group of words that lacks one or more of these
  /// three things. While there are many ways to end up with a fragment, almost
  /// every fragment is simply a result of one of the following three problems:
  /// - It is missing a subject
  /// - It is missing a verb.
  /// - It fails to complete the thought it starts.
  /// Determining if the sentence is a complete thought is difficult to do
  /// programatically!
  bool get fragment => true;

  /// Generally, the adjective order in English is:
  /// Quantity or number
  /// Quality or opinion
  /// Size
  /// Age
  /// Shape
  /// Color
  /// Proper adjective (often nationality, other place of origin, or material)
  /// Purpose or qualifier
  /// [the noun]
  /// - "37,000 dumb, tiny, old, soggy, grey, Norwegian, sports, [balls, etc]"
  List<Token> get adjectives => tokens.where((element) => element.isAdjective).toList();
  List<Token> get nouns => tokens.where((element) => element.isNoun).toList();
  List<Token> get verbs => tokens.where((element) => element.isVerb).toList();
  List<Token> get determiners => tokens.where((element) => element.isDeterminer).toList();
  List<Token> get unknown => tokens.where((element) => element.isUnknown).toList();

  /// The subject of a sentence is the person, place, or thing that is
  /// performing the action of the sentence. The subject represents what or whom
  /// the sentence is about. The simple subject usually contains a noun or
  /// pronoun and can include modifying words, phrases, or clauses.
  /// "The man"
  Token? get subject {
    try {
      if (predicate != null) {
        return nouns.first;
      } else {
        return nouns.last;
      }
    } catch (e) {}
    return null;
  }

  /// The predicate expresses action or being within the sentence. The simple
  /// predicate contains the verb and can also contain modifying words, phrases,
  /// or clauses.
  /// "[The man] builds [a house]"
  Token? get predicate {
    try {
      String predicate = verbs.first.value;
      int predicateIndex = verbs.first.index;
      // print('got predicate: $predicate at $predicateIndex');
      // print('possible preposition: ${tokens.elementAt(predicateIndex + 1).value}');
      if (tokens.elementAt(predicateIndex).isPreposition) {
        predicate += ' ${tokens.elementAt(predicateIndex).value}';
        // print('predicate chain: $predicate');
      }
      return Token.fromString(predicate, predicateIndex);
    } on StateError {
      // print('something happened');
      return null;
    } on RangeError {
      // print('something happened');
      return null;
    } catch (e) {
      print('something happened $e');
      return null;
    }
  }

  /// The direct object receives the action of the sentence. The direct object
  /// is usually a noun or pronoun.
  /// "[The man builds] a house", "[The man builds] it"
  Token? get directObject {
    if (nouns.singleOrNull != null) return nouns.single;
    try {
      return nouns.last;
    } catch (e) {
      return null;
    }
  }

  /// The indirect object indicates to whom or for whom the action of the
  /// sentence is being done. The indirect object is usually a noun or pronoun.
  /// "[The man builds] his family [a house]", "[The man builds] them [a house]"
  Token? get indirectObject {
    //TODO: Fix this
    return null;
    try {
      return determiners.first;
    } catch (e) {
      return null;
    }
  }

  /// A subject complement either renames or describes the subject, and
  /// therefore is usually a noun, pronoun, or adjective. Subject complements
  /// occur when there is a linking verb within the sentence (often a linking
  /// verb is a form of the verb to be).
  /// "The man is a good father", father = noun which renames the subject
  /// "The man seems kind", kind = adjective which describes the subject
  Token? get subjectComplement {
    return null;
    try {
      return adjectives.first;
    } catch (e) {
      return null;
    }
  }

  /// Distilled should drop all words except the most important ones, and should
  /// not repeat words
  List<Token> get distilled {
    bool debugPrint = false;
    List<Token> list = [];
    // if (subject != null) list.add(Token.fromString('subject', subject!.index));
    if (subject != null && debugPrint) print('subject ${subject!}');
    if (subject != null) list.add(subject!);
    // if (subject != null) list.add(Token.fromString('${subject!.index}', subject!.index));
    // if (predicate != null) list.add(Token.fromString('predicate', predicate!.index));
    if (predicate != null && debugPrint) print('predicate ${predicate!}');
    if (predicate != null) list.add(predicate!);
    // if (predicate != null) list.add(Token.fromString('${predicate!.index}', predicate!.index));
    // if (indirectObject != null) list.add(Token.fromString('indirectObject', indirectObject!.index));
    if (indirectObject != null && debugPrint) print('indirectObject ${indirectObject!}');
    if (indirectObject != null) list.add(indirectObject!);
    // if (indirectObject != null) list.add(Token.fromString('${indirectObject!.index}', indirectObject!.index));
    // if (directObject != null) list.add(Token.fromString('directObject', directObject!.index));
    if (directObject != null && debugPrint) print('directObject ${directObject!}');
    if (directObject != null) list.add(directObject!);
    // if (directObject != null) list.add(Token.fromString('${directObject!.index}', directObject!.index));
    // if (subjectComplement != null) list.add(Token.fromString('subjectComplement', subjectComplement!.index));
    if (subjectComplement != null && debugPrint) print('subjectComplement ${subjectComplement!}');
    if (subjectComplement != null) list.add(subjectComplement!);
    // if (subjectComplement != null) list.add(Token.fromString('${subjectComplement!.index}', subjectComplement!.index));
    list.addAll(unknown);
    list.sort((a, b) => a.index.compareTo(b.index));
    if (tokens.singleOrNull != null && list.isEmpty) return tokens;
    // return list.toSet().toList();
    return list.toList();
  }

  @override
  String toString({bool grammar = false}) {
    if (grammar) {
      List<String> types = [];
      types.addAll(tokens.map((e) {
        final int i = tokens.indexOf(e);
        if (e.isConjunction) {
          return '  =>  ';
        }
        if (e.nounExtension != null) {
          return '[${e.primaryType.name} - ${e.nounExtension!.name}]';
        }
        try {
          if (tokens[i - 1].isVerb || tokens[i - 1].isAdjective || tokens[i - 1].isDeterminer) {
            if (e.isVerb && e.isNoun) {
              // if both are verbs this might be a noun
              return '[noun*]';
            }
          }
        } catch (e) {
          // TODO
        }
        return '[${e.primaryType.name}]';
      }));
      return '${types.join('')}';
    }
    return '${tokens.join(' ')}';
  }
}

class Sentence {
  Sentence._(this.text, this.ideas);
  factory Sentence.fromString(String text) {
    List<Idea> ideas = [Idea(index: 0)];
    int i = 0;
    int ii = 0;
    text.split(' ').forEach((element) {
      ii++;
      final token = Token.fromString(element, ii);
      if (token.isConjunction) {
        i++;
        ii = 0;
        ideas.add(Idea(index: i));
      }
      ideas.last.tokens.add(token);
    });
    return Sentence._(text, ideas);
  }
  final String text;

  List<Idea> ideas;

  String asTokens() {
    final list = [];
    ideas.forEach((element) {
      list.add('${element.toString(grammar: true)}');
    });
    return '${list.join('')}';
    // return '${ideas.join(' / ')}';
  }

  String asTokenValues() {
    final list = [];
    ideas.forEach((element) {
      list.add('${element.toString(grammar: false)}');
    });
    return '${list.join('')}';
    // return '${ideas.join(' / ')}';
  }
}
