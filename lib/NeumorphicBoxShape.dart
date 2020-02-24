
import 'package:flutter/cupertino.dart';

class NeumorphicBoxShape {

  final BoxShape boxShape;
  final BorderRadius borderRadius;
  final bool _stadium;

  NeumorphicBoxShape._({this.boxShape, this.borderRadius, bool stadium = false}) : this._stadium = stadium;

  NeumorphicBoxShape.circle() : this._(boxShape: BoxShape.circle);
  NeumorphicBoxShape.roundRect({BorderRadius borderRadius}) : this._(boxShape: BoxShape.rectangle, borderRadius: borderRadius);
  NeumorphicBoxShape.stadium() : this._(boxShape: BoxShape.rectangle, borderRadius: BorderRadius.circular(1000), stadium: true);

  bool get isStadium => boxShape == BoxShape.rectangle && this._stadium == true;
  bool get isCircle => boxShape == BoxShape.circle;
  bool get isRoundRect => boxShape == BoxShape.rectangle && this._stadium == false;
}