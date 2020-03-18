import 'dart:ui';

import 'package:flutter/foundation.dart';

/// A custom offset that define a source of light used to project a shadow of a widget
/// left -1 <= dx <= 1 right
/// top -1 <= dy <= 1 bottom
///
/// constants like "top", "topLeft", "topRight" are providen in LightSource
///
@immutable
class LightSource {
  final double dx;
  final double dy;

  const LightSource(this.dx, this.dy);

  Offset get offset => Offset(dx, dy);

  static const top = const LightSource(0, -1);
  static const topLeft = const LightSource(-1, -1);
  static const topRight = const LightSource(1, -1);
  static const bottom = const LightSource(0, 1);
  static const bottomLeft = const LightSource(-1, 1);
  static const bottomRight = const LightSource(1, 1);
  static const left = const LightSource(-1, 0);
  static const right = const LightSource(1, 0);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LightSource &&
          runtimeType == other.runtimeType &&
          offset == other.offset;

  @override
  int get hashCode => offset.hashCode;

  Offset toOffset(double distance) {
    return offset.scale(distance, distance);
  }

  @override
  String toString() {
    return 'LightSource{dx: $dx, dy: $dy}';
  }

  LightSource invert() => LightSource(dx * -1, dy * -1);

  static LightSource lerp(LightSource a, LightSource b, double t) {
    assert(t != null);

    if (a == null && b == null) return null;
    if (a == null) return b;
    if (b == null) return a;
    if (a == b) return a;
    if (t == 0.0) return a;
    if (t == 1.0) return b;

    return LightSource(
      a.dx != b.dx ? lerpDouble(a.dx, b.dx, t) : a.dx,
      a.dy != b.dy ? lerpDouble(a.dy, b.dy, t) : a.dy,
    );
  }

  LightSource copyWith({
    double dx,
    double dy,
  }) {
    return LightSource(
      dx ?? this.dx,
      dy ?? this.dy,
    );
  }
}
