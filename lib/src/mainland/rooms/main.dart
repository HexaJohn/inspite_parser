import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/story/rooms/room_701.dart';

class MLMain extends PointOfInterest {
  @override
  Message? evaluateSpecial(TextInteraction input) {
    input.lookFor([SoftToken.start(), SoftToken.game()]);
  }

  Message _success() {
    // AppInterface.newGame();
    AppInterface.changeContext(TutorialShipRoom());
    return Message(
        "You wake up in the dark. An unnatural orange glow from outside a window barely illuminates the room.",
        bold: true);
  }
}
