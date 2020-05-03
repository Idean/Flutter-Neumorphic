import '../../../flutter_neumorphic.dart';

class NeumorphicFlutterLogoPathProvider extends NeumorphicPathProvider {
  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return true;
  }

  @override
  Path getPath(Size size) {
    var scaleX = size.width / 166;
    var scaleY = size.height / 202;

    return Path()
      ..moveTo(37.7 * scaleX, 128.9 * scaleY)
      ..lineTo(9.8 * scaleX, 101.0 * scaleY)
      ..lineTo(100.4 * scaleX, 10.4 * scaleY)
      ..lineTo(156.2 * scaleX, 10.4 * scaleY)
      ..moveTo(156.2 * scaleX, 94.0 * scaleY)
      ..lineTo(100.4 * scaleX, 94.0 * scaleY)
      ..lineTo(51.6 * scaleX, 142.8 * scaleY)
      ..lineTo(100.4 * scaleX, 191.6 * scaleY)
      ..lineTo(156.2 * scaleX, 191.6 * scaleY)
      ..lineTo(107.4 * scaleX, 142.8 * scaleY)
      ..close();
  }

  @override
  bool get oneGradientPerPath => true; //one shape(convex/concave) / subPath
}
