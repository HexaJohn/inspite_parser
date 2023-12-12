import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/core/messages.dart';

mixin WearableMixin {
  abstract Message? Function(TextInteraction)? onDon;
  abstract Message? Function(TextInteraction)? onDoff;
}
