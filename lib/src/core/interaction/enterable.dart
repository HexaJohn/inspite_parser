import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/messages.dart';

mixin EnterableMixin {
  Message? onEnter();
  Message? onExit();
  bool canEnter();
  bool canExit();
}
