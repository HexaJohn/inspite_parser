import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:september_flutter/src/core/dictionary.dart';
import 'package:september_flutter/src/core/grammar/token.dart';

class SoftToken {
  /// Accepts a single String, a List of Strings, or will populate identifiers
  /// with the string representation of the object that [SoftToken] is
  /// initialized with.
  String get asHint {
    // print('asHint identifiers ${hashCode}: $identifiers');
    // print('asHint asHint ${hashCode}: ${identifiers.first}');
    return identifiers.first;
  }

  const SoftToken(this._identifiers);

  final List<String> _identifiers;

  List<String> get identifiers => _identifiers.map((e) => e.toUpperCase()).toList()..sort();

  static SoftToken start() {
    return SoftToken(WeakThesarus.start);
  }

  static SoftToken game() {
    return SoftToken(['game', 'videogame', 'adventure', 'playing']);
  }

  static SoftToken next() {
    return SoftToken(['next', 'continue', 'go', 'forward']);
  }

  static SoftToken pants() {
    return SoftToken(['pants', 'pantaloons', 'trousers']);
  }

  static SoftToken jacket() {
    return SoftToken(['jacket', 'coat', 'parka']);
  }

  static SoftToken shoes() {
    return SoftToken(['shoes', 'footwear', 'jays', 'sneakers', 'boots']);
  }

  static SoftToken spyglass() {
    return SoftToken(['telescope', 'spyglass', 'glass']);
  }

  bool contains(Token? element) {
    if (element == null) return false;
    return identifiers.contains(element.value);
  }

  @override
  String toString() {
    return identifiers.first;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SoftToken && listEquals(identifiers, other.identifiers);
  }
}
