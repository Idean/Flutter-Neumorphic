import '../../flutter_neumorphic.dart';
import 'neumorphic_path_provider.dart';

class RectPathProvider extends NeumorphicPathProvider {
  const RectPathProvider({Listenable? reclip});

  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return true;
  }

  @override
  Path getPath(Size size) {
    return Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..close();
  }

  @override
  bool get oneGradientPerPath => false;
}
