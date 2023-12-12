import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/grammar/token_soft.dart';
import 'package:september_flutter/src/core/interaction/interface.dart';
import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/mainland/rooms/entry1.dart';
import 'package:september_flutter/src/story/rooms/room_701.dart';

class MainMenuModule extends RoomDefinition {
  @override
  // TODO: implement locations
  List<EntityInterface> locations = [];

  MainMenuModule({super.name = 'mainMenuModule'});

  @override
  Message? evaluate(TextInteraction input) {
    return null;
  }

  @override
  Message? evaluateSpecial(TextInteraction input) {
    int index = 0;

    if (input.lookFor([
      SoftToken(['mainland'])
    ])) {
      return _startMainland();
    }

    if (App.crumb != null) {
      if (App.crumb!.lookingFor.contains(input.raw.first)) {
        return _startDemo();
      }
    }

    if (Keyword.start.contains(input.segments.first)) {
      index++;

      if (input.raw.length < index + 1) {
        App.setCrumb(StoryCrumb(['game', 'playing', 'adventure', 'story'], () {}));
        return Message('What do you want to ${input.segments.first}?', bold: true);
      } else {
        if (input.lookFor([
          SoftToken(['mainland'])
        ])) {
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
    App.changeContext(TutorialShipRoom());
    return Message(
        "You wake up in the dark. An unnatural orange glow from outside a window barely illuminates the room.",
        bold: true);
  }

  Message? _startMainland() {
    // AppInterface.newGame();
    App.changeContext(MLEntry1());
    return Message.invisible();
    // return Message(
    // '''The sea has rested for several days now, while the sea within me rages. The storm in my heart roars at the idea I alone survived this catastrophe.''',
    // bold: true);
  }
}
