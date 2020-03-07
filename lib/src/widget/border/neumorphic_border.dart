import 'dart:ui';

///
/// Work in progress
/// Add a border inside a [Neumorphic] container
/// The NeumorphicBorder code can changes over time
///
class NeumorphicBorder {
  final Color color;
  final double width;
  final double depth;
  final bool oppositeLightSource;

  NeumorphicBorder({
    this.color,
    this.width,
    this.depth,
    this.oppositeLightSource = true,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NeumorphicBorder && runtimeType == other.runtimeType && color == other.color && width == other.width && depth == other.depth && oppositeLightSource == other.oppositeLightSource;

  @override
  int get hashCode => color.hashCode ^ width.hashCode ^ depth.hashCode ^ oppositeLightSource.hashCode;
}