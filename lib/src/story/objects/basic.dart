import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/grammar/sentence.dart';
import 'package:september_flutter/src/core/grammar/token.dart';
import 'package:september_flutter/src/core/grammar/token_soft.dart';
import 'package:september_flutter/src/core/interaction/interface.dart';
import 'package:september_flutter/src/core/messages.dart';
import 'package:september_flutter/src/core/world/entity.dart';

class BasicSwitch extends EntityInterface {
  BasicSwitch(
      {super.hintText = 'A switch of sorts', super.names = const SoftToken(['switch', 'lights']), super.name = ''});
  bool state = false;

  @override
  Message? evaluate(TextInteraction input) {
    return null;
  }
}

class BasicWindow extends EntityInterface {
  BasicWindow(
      {super.hintText = 'Look outside!', super.names = const SoftToken(['window', 'windows']), super.name = ''});
  bool open = true;

  @override
  Message? evaluate(TextInteraction input) {
    return null;
  }
}

class BasicDoor extends EntityInterface {
  BasicDoor(
      {super.hintText = 'Maybe I should knock?', super.names = const SoftToken(['door', 'entrance']), super.name = ''});
  bool open = false;
  bool locked = true;

  @override
  Message? evaluate(TextInteraction input) {
    return null;
  }
}

class BasicScenery extends Entity {
  BasicScenery(
      {super.hintText = 'A place of sorts', super.names = const SoftToken(['cliff', 'rocks']), super.name = ''});
}
