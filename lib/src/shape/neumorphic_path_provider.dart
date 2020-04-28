import '../../flutter_neumorphic.dart';

abstract class NeumorphicPathProvider extends CustomClipper<Path> {
  const NeumorphicPathProvider({Listenable reclip}) : super(reclip: reclip);

  @override
  Path getClip(Size size) {
    return getPath(size);
  }

  Path getPath(Size size);

  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return false;
  }
}
