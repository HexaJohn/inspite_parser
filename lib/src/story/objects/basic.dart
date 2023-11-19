import 'package:september_flutter/src/core/app.dart';

class BasicSwitch extends PointOfInterest {
  BasicSwitch({hintText = 'A switch of sorts', names = const ['switch', 'lights']});
  bool state = false;
}

class BasicWindow extends PointOfInterest {
  BasicWindow({hintText = 'Look outside!', names = const ['window', 'windows']});
  bool open = true;
}

class BasicDoor extends PointOfInterest {
  BasicDoor({hintText = 'Maybe I should knock?', names = const ['door', 'entrance']});
  bool open = false;
  bool locked = true;
}
