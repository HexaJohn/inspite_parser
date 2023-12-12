import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/messages.dart';

mixin FunctionalMixin {
  Message? onActivate();
  Message? onDeactivate();
  Message? onDamage();
}
