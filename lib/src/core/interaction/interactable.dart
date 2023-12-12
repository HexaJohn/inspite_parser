import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/messages.dart';

mixin InteractableMixin {
  Message? evaluate(TextInteraction input);
  Message? evaluateSpecial(TextInteraction input);
  Message? onInteract();
  Message? onNothingHappened();
}
