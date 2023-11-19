import 'package:september_flutter/src/core/dictionary/adjectives.dart';
import 'package:september_flutter/src/core/dictionary/adverbs.dart';
import 'package:september_flutter/src/core/dictionary/conjunctions_coordinating.dart';
import 'package:september_flutter/src/core/dictionary/determiners.dart';
import 'package:september_flutter/src/core/dictionary/interjections.dart';
import 'package:september_flutter/src/core/dictionary/nouns.dart';
import 'package:september_flutter/src/core/dictionary/nouns_animals.dart';
import 'package:september_flutter/src/core/dictionary/nouns_body_parts.dart';
import 'package:september_flutter/src/core/dictionary/nouns_plural.dart';
import 'package:september_flutter/src/core/dictionary/nouns_proper.dart';
import 'package:september_flutter/src/core/dictionary/prepositions.dart';
import 'package:september_flutter/src/core/dictionary/pronouns.dart';
import 'package:september_flutter/src/core/dictionary/verbs.dart';
import 'package:september_flutter/src/core/dictionary/vulgar.dart';

/// https://www.butte.edu/departments/cas/tipsheets/grammar/parts_of_speech.html
class Token {
  Token._(this.value, {this.index = 0});

  factory Token.fromString(String string, int index) => Token._(string.toUpperCase(), index: index);
  factory Token.placeholder() => Token._('');

  String value;
  int index;

  /// The verb in a sentence expresses action or being. There is a main verb and
  /// sometimes one or more helping verbs. ("She can sing." Sing is the main
  /// verb; can is the helping verb.) A verb must agree with its subject in
  /// number (both are singular or both are plural). Verbs also take different
  /// forms to express tense.
  ///
  /// - Sing, dance, run, write, think
  bool get isVerb => verbs.contains(value);

  /// An adverb describes or modifies a verb, an adjective, or another adverb,
  /// but never a noun. It usually answers the questions of when, where, how,
  /// why, under what conditions, or to what degree. Adverbs often end in -ly.
  ///
  /// - Gently, extremely, carefully, well
  bool get isAdverb => adverbs.contains(value);

  /// An adjective is a word used to modify or describe a noun or a pronoun. It
  /// usually answers the question of which one, what kind, or how many.
  /// (Articles [a, an, the] are usually classified as adjectives.)
  ///
  /// - Pretty, old, blue, smart
  bool get isAdjective => adjectives.contains(value);

  /// A noun is a word for a person, place, thing, or idea. Nouns are often used
  /// with an article (the, a, an), but not always. Proper nouns always start
  /// with a capital letter; common nouns do not. Nouns can be singular or
  /// plural, concrete or abstract. Nouns show possession by adding 's. Nouns
  /// can function in different roles within a sentence; for example, a noun can
  /// be a subject, direct object, indirect object, subject complement, or
  /// object of a preposition.
  ///
  /// - Man, college, house, happiness
  bool get isNoun => nouns.contains(value);

  /// A pronoun is a word used in place of a noun. A pronoun is usually
  /// substituted for a specific noun, which is called its antecedent.
  /// Pronouns are further defined by type:
  /// - Personal pronouns refer to specific persons or things.
  /// - Possessive pronouns indicate ownership.
  /// - Reflexive pronouns are used to emphasize another noun or pronoun.
  /// - Relative pronouns introduce a subordinate clause.
  /// - Demonstrative pronouns identify, point to, or refer to nouns.
  ///
  /// - She, we, they, it
  bool get isPronoun => pronouns.contains(value);

  /// A preposition is a word placed before a noun or pronoun to form a phrase
  /// modifying another word in the sentence. Therefore a preposition is always
  /// part of a prepositional phrase. The prepositional phrase almost always
  /// functions as an adjective or as an adverb. The following list includes the
  /// most common prepositions:
  ///
  /// by [the tree], with [our friends], about [the book], until [tomorrow])
  bool get isPreposition => prepositions.contains(value);

  /// A conjunction joins words, phrases, or clauses, and indicates the
  /// relationship between the elements joined. Coordinating conjunctions
  /// connect grammatically equal elements: and, but, or, nor, for, so, yet.
  /// Subordinating conjunctions connect clauses that are not equal: because,
  /// although, since, etc. There are other types of conjunctions as well.
  ///
  /// - And, but, or, while, because
  bool get isConjunction => conjunctions.contains(value);

  /// An interjection is a word used to express emotion. It is often followed by
  /// an exclamation point.
  ///
  /// - Oh!, Wow!, Oops!
  bool get isInterjection => interjections.contains(value);

  /// English determiners (also known as determinatives) are words such that are
  /// most commonly used with nouns to specify their referents. The determiners
  /// form a closed lexical category in English.
  /// - the, a, each, some, which, this, six
  bool get isDeterminer => determiners.contains(value);

  bool get isVulgar => vulgar.contains(value);

  bool get isUnknown => primaryType == TokenType.unknown;

  TokenType get primaryType {
    if (isVerb) {
      return TokenType.verb;
    } else if (isAdverb) {
      return TokenType.adverb;
    } else if (isAdjective) {
      return TokenType.adjective;
    } else if (isNoun) {
      return TokenType.noun;
    } else if (isPronoun) {
      return TokenType.pronoun;
    } else if (isPreposition) {
      return TokenType.preposition;
    } else if (isConjunction) {
      return TokenType.conjunction;
    } else if (isInterjection) {
      return TokenType.interjection;
    } else if (isDeterminer) {
      return TokenType.determiner;
    } else if (isVulgar) {
      return TokenType.vulgar;
    } else {
      return TokenType.unknown;
    }
  }

  NounExtension? get nounExtension {
    if (isNoun) {
      if (nounsAnimals.contains(value)) {
        return NounExtension.animal;
      } else if (nounsBodyParts.contains(value)) {
        return NounExtension.bodyPart;
      } else if (nounsPlural.contains(value)) {
        return NounExtension.plural;
      } else if (nounsProper.contains(value)) {
        return NounExtension.proper;
      }
    }
    return null;
  }

  @override
  String toString({bool grammar = false}) {
    if (grammar) {
      // List<String> types = [];
      // types.addAll(tokens.map((e) {
      //   final int i = tokens.indexOf(e);
      //   if (e.isConjunction) {
      //     return '  =>  ';
      //   }
      //   if (e.nounExtension != null) {
      //     return '[${e.primaryType.name} - ${e.nounExtension!.name}]';
      //   }
      //   try {
      //     if (tokens[i - 1].isVerb || tokens[i - 1].isAdjective || tokens[i - 1].isDeterminer) {
      //       if (e.isVerb && e.isNoun) {
      //         // if both are verbs this might be a noun
      //         return '[noun*]';
      //       }
      //     }
      //   } catch (e) {
      //     // TODO
      //   }
      //   return '[${e.primaryType.name}]';
      // }));
      // return '${types.join('')}';
      return value;
    }
    return value;
  }
}

enum TokenType {
  verb,
  adverb,
  adjective,
  noun,
  pronoun,
  preposition,
  conjunction,
  interjection,
  determiner,
  vulgar,
  unknown,
}

enum NounExtension {
  animal,
  bodyPart,
  plural,
  proper,
}
