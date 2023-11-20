import 'package:september_flutter/src/core/app.dart';

class BasicSwitch extends PointOfInterest {
  BasicSwitch(
      {super.hintText = 'A switch of sorts', super.names = const SoftToken(['switch', 'lights']), super.name = ''});
  bool state = false;
}

class BasicWindow extends PointOfInterest {
  BasicWindow(
      {super.hintText = 'Look outside!', super.names = const SoftToken(['window', 'windows']), super.name = ''});
  bool open = true;
}

class BasicDoor extends PointOfInterest {
  BasicDoor(
      {super.hintText = 'Maybe I should knock?', super.names = const SoftToken(['door', 'entrance']), super.name = ''});
  bool open = false;
  bool locked = true;
}

class BasicScenery extends PointOfInterest {
  BasicScenery(
      {super.hintText = 'A switch of sorts', super.names = const SoftToken(['switch', 'lights']), super.name = ''});
  bool state = false;
}
