# flutter_neumorphic

[![top_banner](./medias/top_banner.png)](https://www.idean.com/)

A complete, ready to use, Neumorphic ui kit for Flutter

Try Flutter-Neumorphic on your browser : 👉 https://flutter-neumorphic.firebaseapp.com/ 🌐

[![neumorphic_playground](./medias/playground.gif)](https://github.com/Idean/Flutter-Neumorphic)

# ⚙️ Installation

https://pub.dev/packages/flutter_neumorphic

[![pub package](https://img.shields.io/pub/v/flutter_neumorphic.svg)](
https://pub.dartlang.org/packages/flutter_neumorphic)
[![pub package](https://api.codemagic.io/apps/5e6113f78b547c3c80edbdb3/5e6113f78b547c3c80edbdb2/status_badge.svg)](https://github.com/Idean/Flutter-Neumorphic)


```dart
dependencies:
  flutter_neumorphic: ^1.0.3
```

The in your .dart files 
```dart
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
```

# 🗂 Widgets

<table>
<thead>
<tr>
<th>Preview</th>
<th>Widget</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
  <td><img width="300px" src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/widgets/container.gif"/></td>
  <td><a href="https://github.com/Idean/Flutter-Neumorphic/blob/master/doc/Neumorphic.md">Neumorphic</a></td>
  <td>The main Neumorphic Widget, a container which adds white/dark gradient depending on a lightsource and a depth </td>
</tr>
<tr>
  <td><img width="300px" src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/widgets/button.gif"/></td>
  <td><a href="https://github.com/Idean/Flutter-Neumorphic/blob/master/doc/NeumorphicButton.md">NeumorphicButton</a></td>
  <td>A neumorphic button that plays with the depth to respond to user interraction</td>
</tr>
<tr>
  <td><img width="300px" src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/widgets/radio.gif"/></td>
  <td><a href="https://github.com/Idean/Flutter-Neumorphic/blob/master/doc/NeumorphicRadio.md">NeumorphicRadio</a></td>
  <td>A set of neumorphic button whith only one selected at time, depending on a value and groupValue</td>
</tr>
<tr>
  <td><img width="300px" src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/widgets/checkbox.gif"/></td>
  <td><a href="https://github.com/Idean/Flutter-Neumorphic/blob/master/doc/NeumorphicCheckbox.md">NeumorphicCheckbox</a></td>
  <td> A button associated with a value, can be checked/unckecked, if checked, takes the accent color</td>
</tr>
<tr>
  <td><img width="300px" src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/widgets/switch.gif"/> </td>
  <td><a href="https://github.com/Idean/Flutter-Neumorphic/blob/master/doc/NeumorphicSwitch.md">NeumorphicSwitch</a></td>
  <td>An On/Off toggle, associated with a value, if toggled, takes the accent color </td>
</tr>
<tr>
  <td><img width="300px" src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/widgets/toggle.gif"/> </td>
  <td><a href="https://github.com/Idean/Flutter-Neumorphic/blob/master/doc/NeumorphicSwitch.md">NeumorphicToggle</a></td>
  <td>An mutiple value toggle, associated with a selecteedIndex</td>
</tr>
<tr>
  <td><img width="300px" src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/widgets/slider.gif"/></td>
  <td><a href="https://github.com/Idean/Flutter-Neumorphic/blob/master/doc/NeumorphicSlider.md">NeumorphicSlider</a></td>
  <td>A Neumorphic seekbar (range slider), the user can select a value in a range</td>
</tr>
<tr>
  <td><img width="300px" src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/widgets/progress.gif"/></td>
  <td><a href="https://github.com/Idean/Flutter-Neumorphic/blob/master/doc/NeumorphicProgress.md">NeumorphicProgress</a></td>
  <td>A determinate progress, takes the displayed percentage</td>
</tr>
<tr>
  <td><img width="300px"src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/widgets/indeterminate.gif"/> </td>
  <td><a href="https://github.com/Idean/Flutter-Neumorphic/blob/master/doc/NeumorphicProgress.md">NeumorphicIndeterminateProgress</a></td>
  <td>An inderminate progress-bar</td>
</tr>
<tr>
  <td><img src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/widgets/background.png"/> </td>
  <td><a href="https://github.com/Idean/Flutter-Neumorphic/blob/master/doc/NeumorphicBackground.md">NeumorphicBackground</a></td>
  <td>Take the background color of the theme, can clip the screen with a borderRadius</td>
</tr>

</tbody>
</table>

## 👀 Showcases

[![Neumorphic](./medias/samples/sample_form.png)](https://github.com/Idean/Flutter-Neumorphic)
[![Neumorphic](./medias/samples/sample_clock.png)](https://github.com/Idean/Flutter-Neumorphic)

[![Neumorphic](./medias/samples/sample_galaxy.png)](https://github.com/Idean/Flutter-Neumorphic)
[![Neumorphic](./medias/samples/sample_widgets.png)](https://github.com/Idean/Flutter-Neumorphic)

## 📦 Neumorphic

```dart

Neumorphic(
  boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(12)), 
  style: NeumorphicStyle(
    shape: NeumorphicShape.concave,
    depth: 8,
    lightSource: LightSource.topLeft,
    color: Colors.grey
  ),
  child: ...
)
```

[![Neumorphic](./medias/neumorphic_container.gif)](https://github.com/Idean/Flutter-Neumorphic)
[![Neumorphic](./medias/neumorphic_circle_container.gif)](https://github.com/Idean/Flutter-Neumorphic)

☝️ Playing with LightSource & Depth


### 🛠️ Attributes


| Attributes | Values | Description |
|------------|--------|-------------|
| LightSource | TopLeft, BottomRight, etc. / (dx, dy) | The source of light specifit to the theme or the widget, used to project white/dark shadows on neumorphic elements |
| [Shape](#-shapes) | Concave / Convex / Flat | The shape of the curve used in the neumorphic container |
| Depth | -20 <= double <= 20 | The distance of the widget to his parent. Can be negative => emboss. It influences on the shadow's color and its size/blur |
| Intensity | 0 <= double <= 1 | The intensity of the Light, it influences on the shadow's color |
| Color | any Color | The default color of  Neumorphic elements | 
| Accent | any Color | The default accent color of the Neumorphic element when activated (eg: checkbox) | 
| Variant | any Color | The default secondary color of the Neumorphic element (eg: used as second color on the progress gradient) | 
| BoxShape | Circle, RoundRect(radius), Stadium | The box shape of a Neumorphic element. Stadium : roundrect with cirlces on each side | 

### 🔧 Shapes

<table>
<thead>
<tr>
<th>Shape</th>
<th>Widget</th>
<th>Image</th>
<th>Condition</th>
</tr>
</thead>
<tbody>

<tr>
  <td>Flat</td>
  <td><img src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/shapes/widget_flat.png"/></td>
  <td><img src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/shapes/flat.png"/> </td>
  <td>depth >= 0 && shape == Flat</td>
</tr>


<tr>
  <td>Convex</td>
  <td><img src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/shapes/widget_convex.png"/></td>
  <td><img src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/shapes/convex.png"/> </td>
  <td>depth >= 0 && shape == Convex</td>
</tr>



<tr>
  <td>Concave</td>
  <td><img src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/shapes/widget_concave.png"/></td>
  <td><img src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/shapes/concave.png"/> </td>
  <td>depth >= 0 && shape == Concave</td>
</tr>


<tr>
  <td>Emboss</td>
  <td><img src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/shapes/widget_emboss.png"/></td>
  <td><img src="https://github.com/Idean/Flutter-Neumorphic/raw/master/medias/shapes/emboss.png"/> </td>
  <td>depth < 0</td>
</tr>

</tbody>
</table>

## 🎨 Neumorphic Theme


[![neumorphic_theme](./medias/toggleDark.gif)](https://github.com/Idean/Flutter-Neumorphic)
[![neumorphic_theme](./medias/toggleTheme.gif)](https://github.com/Idean/Flutter-Neumorphic)

```dart
NeumorphicTheme(
    usedTheme: UsedTheme.LIGHT, //or DARK / SYSTEM
    darkTheme: NeumorphicThemeData(
        baseColor: Color(0xff333333),
        accentColor: Colors.green,
        lightSource: LightSource.topLeft,
        depth: 4,
        intensity: 0.3,
    ),
    theme: NeumorphicThemeData(
        baseColor: Color(0xffDDDDDD),
        accentColor: Colors.cyan,
        lightSource: LightSource.topLeft,
        depth: 6,
        intensity: 0.5,
    ),
    child: ...
)
```

To retrieve the current used theme :

```dart
final theme = NeumorphicTheme.currentTheme(context);
final baseColor = theme.baseColor;
final accentColor = theme.accentColor;
...
```

Toggle from light to dark
```dart
NeumorphicTheme.of(context).currentTheme = CurrentTheme.DARK;
```

Know if using dark
```dart
if(NeumorphicTheme.of(context).isUsingDarkMode){
  
}
```

# What's neumorphic

[![neumorphic](./medias/neumorphic.jpg)]()

## Material Cards

A Modern / Material (upgraded) card usually is a surface floating on top of our perceived background and casting a shadow onto it. The shadow both gives it depth and also in many cases defines the shape itself — as it’s quite often borderless.

## Neumorphic cards

Neumorphic card however pretends to extrude from the background. It’s a raised shape made from the exact same material as the background. When we look at it from the side we see that it doesn’t “float”.

[![neumorphic_button](./medias/button_press.gif)](https://github.com/Idean/Flutter-Neumorphic)

Here's a Nereumorphic Button tap (slowed x2) from the sample app, you can see how the element seems to change its depth to its surface.


# 👥 Contributors


|                                                                                | Contributors |
|:------------------------------------------------------------------------------:|--------------|
| [![florent](./medias/contributors/florent.jpeg)](https://github.com/florent37) | [Florent Champigny](https://github.com/florent37) |
| [![olivier](./medias/contributors/olivier.png)](https://github.com/Debilobob)  | [Olivier Bonvila](https://github.com/Debilobob)  |
| [![gyl](./medias/contributors/gyl.png)](https://github.com/almighty972)        | [Gyl Jean Lambert](https://github.com/almighty972)  |


## 📄 License


Flutter-Neumorphic is released under the Apache2 license.
See [LICENSE](./LICENSE) for details.

If you use the open-source library in your project, please make sure to credit and backlink to www.idean.com

[![bottom_banner](./medias/bottom_banner.png)](https://www.idean.com)
