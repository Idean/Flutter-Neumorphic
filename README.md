# flutter_neumorphic

```dart
NeumorphicContainer(
  style: NeumorphicStyle(
    borderRadius: 40,
    shape: NeumorphicShape.concave,
  ),
  child: SizedBox(
    height: 200,
    width: 200,
  ),
)
```

```dart
Provider<NeumorphicTheme>.value(
      
      value: NeumorphicTheme(
        lightSource: LightSource.bottomLeft,
        distance: 5,
        blur: 6
      ),
      
      ...
      
      child: NeumorphicContainer(
        style: NeumorphicStyle(
          borderRadius: 40,
          shape: NeumorphicShape.concave,
        ),
        child: SizedBox(
          height: 200,
          width: 200,
        ),
      )
      
);
```

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
