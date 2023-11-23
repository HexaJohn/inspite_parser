import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/story/objects/basic.dart';
import 'package:september_flutter/src/story/rooms/devoid.dart';
import 'package:september_flutter/src/story/rooms/empty.dart';

class MLCliff extends VoidRoom {
  MLCliff() {
    locations = [
      cliffRocks,
      cliffOcean,
      cliffFall,
      cliffIsland,
      cliffMe,
      cliffJacket,
      cliffBlacks,
      cliffBirds,
      cliffShore,
      cliffShip,
      handkerchiefSearch,
      saltwater,
      spyglassSearch
    ];
  }
  @override
  String get title => 'At the Edge of the Cliff';
  @override
  String get description => "";

  bool clean = false;
  bool birds = false;
  bool lost = false;
  bool turn = false;
  bool wait = false;

  @override
  Message? evaluate(TextInteraction input) {
    return null;
  }

  Message? evaluateSpecial(TextInteraction input) {
    if (input.lookFor([
          SoftToken(['turn'])
        ]) ||
        input.lookFor([
          SoftToken(['turn', 'around'])
        ])) {
      if (turn) {
        return Message('I see nothing of interest.');
      } else {
        turn = true;
        return Message(
            '''A shadow sweeps across the rocks in the corner of my eye as the wind begins to push, clearing the cliff of debris.

My eyes must deceive me...''');
      }
    }
    return null;
  }

  @override
  Message? onEnter() {
    // if (inside) return Message("I'm already here");

    AppInterface.addMessage(Message.storytelling(subdefinitions));

    return null;
  }

  @override
  Message? onNothingHappened() {
    return Message('I must collect my thoughts');
  }

  @override
  Message? onExit() {
    return Message('I do not want to leave yet.');
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
  bool get inside => AppInterface.currentRoom.runtimeType == runtimeType;
}

final BasicScenery cliffRocks = (BasicScenery(
  name: 'cliffRocks',
  hintText: 'I stand on the edge of the cliff.',
  names: const SoftToken(['cliff', 'rocks']),
));

final BasicScenery cliffOcean = (BasicScenery(
  name: 'cliffOcean',
  hintText: 'The sea has grown wild again, swelling with my fears, engulfing the rocks below.',
  names: const SoftToken(['ocean', 'waves']),
));

final BasicScenery cliffFall = (BasicScenery(
  name: 'cliffFall',
  hintText: 'A powerful gust pushes me back from the edge.',
  names: const SoftToken(['fall', 'edge']),
));

final BasicScenery cliffIsland = BasicScenery(
    name: 'cliffIsland',
    hintText:
        'But it is too early to leave. I can still make out the far island with my spyglass before everything becomes veiled in a curtain of rain.',
    names: const SoftToken(['fall', 'edge']));

final BasicScenery cliffMe = (BasicScenery(
  name: 'cliffMe',
  hintText: 'I adjust the old telescope.',
  names: const SoftToken(['fall', 'edge']),
));

final BasicScenery cliffJacket = (BasicScenery(
  name: 'cliffJacket',
  hintText: 'The wind snaps the hem of my jacket against my legs.',
  names: const SoftToken(['fall', 'edge']),
));

final BasicScenery cliffBlacks = (BasicScenery(
  name: 'cliffBlacks',
  hintText: '',
  names: const SoftToken(['fall', 'edge']),
));

final BasicScenery cliffBirds = (BasicScenery(
  name: 'cliffBirds',
  hintText: '',
  names: const SoftToken(['fall', 'edge']),
));

final BasicScenery cliffShore = (BasicScenery(
  name: 'cliffShore',
  hintText: '',
  names: const SoftToken(['fall', 'edge']),
));

final BasicScenery cliffShip = (BasicScenery(
  name: 'cliffShip',
  hintText: '',
  names: const SoftToken(['fall', 'edge']),
));

final BasicScenery handkerchiefSearch = (BasicScenery(
  name: 'handkerchiefSearch',
  hintText: '',
  names: const SoftToken(['handkerchief']),
));

final BasicScenery saltwater = (BasicScenery(
  name: 'saltwater',
  hintText: '',
  names: const SoftToken(['water', 'seawater', 'saltwater']),
));

final BasicScenery spyglassSearch = (BasicScenery(
  name: 'spyglassSearch',
  hintText: '',
  names: const SoftToken(['spyglass', 'telescope']),
));
