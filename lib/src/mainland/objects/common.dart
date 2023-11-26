import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/grammar/sentence.dart';
import 'package:september_flutter/src/core/grammar/token.dart';
import 'package:september_flutter/src/core/grammar/token_soft.dart';
import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/story/objects/basic.dart';

final BasicItem jacket = BasicItem(
  name: 'jacket',
  hintText: 'A powerful gust pushes me back from the edge.',
  names: const SoftToken(['jacket', 'coat']),
  specialResponses: {
    SoftToken(['remove', 'take off']): (TextInteraction input) {
      // final Idea sentence = input.toSentence().ideas.first;
      // final Token? preposition =
      // sentence.tokens.firstWhere((element) => element.isPreposition, orElse: () => Token.fromString('', -1));
      // final Token? predicate = sentence.predicate ?? null;
      // print('debug preposition!!! ${preposition?.value}');

      // //TODO Actually implement this
      // input.lookFor([
      //   SoftToken(['TAKE']),
      //   SoftToken(['OFF'])
      // ]);

      // if (preposition?.value != 'OFF' && predicate?.value == 'TAKE') return null;
      if (App.location == 'cliff') {
        return Message(
            'I take off my jacket. Blasts of freezing wind feel like a hundred icy javelins tossed from the depths by Triton.');
      }
      return Message('I let the jacket slip from my shoulders.');
    },
  },
);
