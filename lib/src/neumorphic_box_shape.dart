import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_neumorphic/src/shape/rrect_path_provider.dart';
import 'package:flutter_neumorphic/src/shape/stadium_path_provider.dart';

import 'shape/beveled_path_provider.dart';
import 'shape/circle_path_provider.dart';
import 'shape/neumorphic_path_provider.dart';
import 'shape/rect_path_provider.dart';

export 'shape/path/flutter_logo_path_provider.dart';

/// Define a Neumorphic container box shape

class NeumorphicBoxShape {
  final NeumorphicPathProvider customShapePathProvider;

  const NeumorphicBoxShape._(this.customShapePathProvider);

  const NeumorphicBoxShape.circle() : this._(const CirclePathProvider());

  const NeumorphicBoxShape.path(NeumorphicPathProvider pathProvider)
      : this._(pathProvider);

  const NeumorphicBoxShape.rect() : this._(const RectPathProvider());

  const NeumorphicBoxShape.stadium() : this._(const StadiumPathProvider());

  NeumorphicBoxShape.roundRect(BorderRadius borderRadius)
      : this._(RRectPathProvider(borderRadius));

  NeumorphicBoxShape.beveled(BorderRadius borderRadius)
      : this._(BeveledPathProvider(borderRadius));

  bool get isCustomPath =>
      !isStadium && !isRect && !isCircle && !isRoundRect && !isBeveled;

  bool get isStadium =>
      customShapePathProvider.runtimeType == StadiumPathProvider;

  bool get isCircle =>
      customShapePathProvider.runtimeType == CirclePathProvider;

  bool get isRect => customShapePathProvider.runtimeType == RectPathProvider;

  bool get isRoundRect =>
      customShapePathProvider.runtimeType == RRectPathProvider;

  bool get isBeveled =>
      customShapePathProvider.runtimeType == BeveledPathProvider;

  static NeumorphicBoxShape? lerp(
      NeumorphicBoxShape? a, NeumorphicBoxShape? b, double t) {
    if (a == null && b == null) return null;

    if (t == 0.0) return a;
    if (t == 1.0) return b;

    if (a == null) {
      if (b!.isCircle || b.isRect || b.isStadium || b.isCustomPath) {
        return b;
      } else {
        return NeumorphicBoxShape.roundRect(BorderRadius.lerp(
          null,
          (b.customShapePathProvider as RRectPathProvider).borderRadius,
          t,
        )!);
      }
    }
    if (a.isCircle || a.isRect || a.isStadium || a.isCustomPath) {
      return a;
    }

    if (b == null) {
      if (a.isCircle || a.isRect || a.isStadium || a.isCustomPath) {
        return a;
      } else {
        return NeumorphicBoxShape.roundRect(BorderRadius.lerp(
          null,
          (a.customShapePathProvider as RRectPathProvider).borderRadius,
          t,
        )!);
      }
    }
    if (b.isCircle || b.isRect || b.isStadium || b.isCustomPath) {
      return b;
    }

    if (a.isBeveled && b.isBeveled) {
      return NeumorphicBoxShape.beveled(BorderRadius.lerp(
        (a.customShapePathProvider as BeveledPathProvider).borderRadius,
        (b.customShapePathProvider as BeveledPathProvider).borderRadius,
        t,
      )!);
    }

    return NeumorphicBoxShape.roundRect(BorderRadius.lerp(
      (a.customShapePathProvider as RRectPathProvider).borderRadius,
      (b.customShapePathProvider as RRectPathProvider).borderRadius,
      t,
    )!);
  }
}
