import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/messages.dart';

class BasicSwitch extends PointOfInterest {
  BasicSwitch(
      {super.hintText = 'A switch of sorts', super.names = const SoftToken(['switch', 'lights']), super.name = ''});
  bool state = false;

  @override
  Message? evaluate(TextInteraction input) {
    return null;
  }
}

class BasicWindow extends PointOfInterest {
  BasicWindow(
      {super.hintText = 'Look outside!', super.names = const SoftToken(['window', 'windows']), super.name = ''});
  bool open = true;

  @override
  Message? evaluate(TextInteraction input) {
    return null;
  }
}

class BasicDoor extends PointOfInterest {
  BasicDoor(
      {super.hintText = 'Maybe I should knock?', super.names = const SoftToken(['door', 'entrance']), super.name = ''});
  bool open = false;
  bool locked = true;

  @override
  Message? evaluate(TextInteraction input) {
    return null;
  }
}

class BasicScenery extends PointOfInterest {
  BasicScenery(
      {super.hintText = 'A switch of sorts', super.names = const SoftToken(['switch', 'lights']), super.name = ''});
  bool state = false;

  Message? Function(TextInteraction) function;

  @override
  Message? evaluate(TextInteraction input) => function(input);
}
