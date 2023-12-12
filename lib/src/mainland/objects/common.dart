import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/grammar/token_soft.dart';
import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/core/world/entity.dart';

final Entity jacket = Entity(
  name: 'jacket',
  hintText: 'A powerful gust pushes me back from the edge.',
  names: const SoftToken(['jacket', 'coat']),
  onDoff: (input) {
    if (App.location == 'cliff') {
      return Message(
          'I take off my jacket. Blasts of freezing wind feel like a hundred icy javelins tossed from the depths by Triton.');
    }
    return Message('I let the jacket slip from my shoulders.');
  },
  onDon: (input) {
    if (App.location == 'cliff') {
      return Message('Without this jacket I would be a poorer man.');
    }
    return Message('I am wearing my jacket.');
  },
);
final Entity shoes = Entity(
  name: 'shoes',
  hintText: 'A powerful gust pushes me back from the edge.',
  names: const SoftToken(['jacket', 'coat']),
  specialResponses: {
    SoftToken(['remove', 'take off']): (TextInteraction input) {
      if (App.location == 'cliff') {
        return Message(
            'I take off my jacket. Blasts of freezing wind feel like a hundred icy javelins tossed from the depths by Triton.');
      }
      return Message('I let the jacket slip from my shoulders.');
    },
  },
);
