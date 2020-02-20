import 'dart:ui';

enum LightSource {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

Offset sourceToOffset(LightSource source, double distance) {
  Offset off;
  switch (source) {
    case LightSource.bottomLeft:
      off = Offset(distance, -distance);
      break;
    case LightSource.topLeft:
      off = Offset(distance, distance);
      break;
    case LightSource.topRight:
      off = Offset(-distance, distance);
      break;
    case LightSource.bottomRight:
      off = Offset(-distance, -distance);
      break;
  }
  return off;
}

Offset mergeOffsetWithDistance(Offset offset, double distance,
    {bool capTo1 = false}) {
  double dx = offset.dx;
  double dy = offset.dy;
  if (capTo1) {
    if (dx < 0) dx = 0;
    if (dx > 1) dx = 1;

    if (dy < 0) dy = 0;
    if (dy > 1) dy = 1;
  }
  return Offset(dx * distance, dy * distance);
}

Offset embrossOffset({LightSource lightSource, bool dark, double distance}){
  if(dark){
    switch(lightSource){
      case LightSource.topLeft:
        return  Offset(-distance, -distance);
        break;
      case LightSource.topRight:
        return  Offset(distance, - distance);
        break;
      case LightSource.bottomLeft:
        return  Offset(- distance, distance);
        break;
      case LightSource.bottomRight:
        return  Offset(distance, distance);
        break;
    }
  } else {
    switch(lightSource){
      case LightSource.topLeft:
        return Offset(distance, distance);
        break;
      case LightSource.topRight:
        return Offset(-distance, distance);
        break;
      case LightSource.bottomLeft:
        return Offset(distance, -distance);
        break;
      case LightSource.bottomRight:
        return Offset(-distance, -distance);
        break;
    }
  }

  return null;

}