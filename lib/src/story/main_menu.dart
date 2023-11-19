import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/story/rooms/room_701.dart';

class MainMenuModule extends PointOfInterest {
  @override
  Message? evaluateSpecial(TextInteraction input) {
    int index = 0;

    if (input.lookFor([SoftToken('mainland')])) {
      return _startMainland();
    }

    if (AppInterface.crumb != null) {
      if (AppInterface.crumb!.lookingFor.contains(input.raw.first)) {
        return _startDemo();
      }
    }

    if (Keyword.start.contains(input.segments.first)) {
      index++;

      if (input.raw.length < index + 1) {
        AppInterface.setCrumb(StoryCrumb(['game', 'playing', 'adventure', 'story'], () {}));
        return Message('What do you want to ${input.segments.first}?', bold: true);
      } else {
        if (input.lookFor([SoftToken('mainland')])) {
          return _startMainland();
        }
        if (input.lookFor([SoftToken.game()])) {
          return _startDemo();
        } else {
          return Message('And I want to win the lottery', italic: true);
        }
      }
    }
    return null;
  }

  Message _startDemo() {
    // AppInterface.newGame();
    AppInterface.changeContext(TutorialShipRoom());
    return Message(
        "You wake up in the dark. An unnatural orange glow from outside a window barely illuminates the room.",
        bold: true);
  }

  Message _startMainland() {
    // AppInterface.newGame();
    AppInterface.changeContext(TutorialShipRoom());
    return Message(
        '''The sea has rested for several days now, while the sea within me rages. The storm in my heart roars at the idea I alone survived this catastrophe. I spent quite some hours on deck staring along the horizon, blasted by the salt spray.  I have been well in light of the possibilities that surround me, although weak. Even keeping a record of my activities often exhausts me to the point of despair. More than once I have pondered whether anyone will ever review these entries, or whether I wish them to. I imagine my diary will be placed in the hands of my beloved, so she may learn what I have gone through to place it there and feel my love, for it has been more than the incredible journey we dreamed of. Truth be told, if I say not a word as the black, wretched loneliness creeps into my quarters, I may hold fast to the hope I will return to her side. Alas, my strength wanes.''',
        bold: true);
  }
}
