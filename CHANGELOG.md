## 3.0.3

* Fixed issue on button / theme
* Improved NeumorphicApp

## 3.0.2

* Fixed issue on NeumorphicButton + Theme

## 3.0.1

* Added customization of icons in NeumorphicAppBar
* Updated NeumorphicAppBar samples

## 3.0.0

* Added `NeumorphicText` (only positive depth)
* Added `NeumorphicIcon` (work with svg)
* `NeumorphicBoxShape` is now an element of `NeumorphicStyle`
* Added NeumorphicApp, NeumorphicAppBar
* Improved NeumorphicTheme (handles more styles)
* Neumorphic now include Material
* Refactored Progress animations

## 2.2.2

* Added NeumorphicButton.tooltip optional parameter

## 2.2.1

* Added Beveled shape

## 2.2.0

* Renamed NeumorphicButton.`onClick` to NeumorphicButton.`onPressed`
* Added `NeumorphicTextStyle`

## 2.1.0+1

* Added NeumorphicText (beta)
* Added NeumorphicIcon
* Updated samples

## 2.0.1

* Added selected/unselected color on Radio
* Fixed min flutter version to `1.13.18`

## 2.0.0

* Rewritten all NeumorphicDecoration
* Improved drawing cache & performances
* Full support of custom path
* Added `NeumorphicPathProvider`
* Added `NeumorphicFlutterLogoPathProvider`
* Added `NeumorphicBorder` on styles / themes 

## 1.0.8+3

* Added `textStyle` to Neumorphic Container, to avoid text coloration issues
* Added `AnimatedDefaultTextStyle` inside Neumorphic, by default it takes the `material.Theme.of(context).textTheme.body2`

## 1.0.8

* Added `backgroundColor` in Toggle style

## 1.0.7

* Added implementation of `custom path` shapes

## 1.0.5+1

* Added shadow colors customization 
* - shadowLightColor,
* - shadowDarkColor,
* - shadowLightColorEmboss,
* - shadowDarkColorEmboss,

## 1.0.4

* Fixed BorderRadius.only
* Fixed Slider thumb position
* Added `curve` on any widget to customize implicits animations
* Added `NeumorphicToggle` widget

## 1.0.3

* Added a `disableDepth` boolean configuration in theme & styles

## 1.0.2+2

* Some widgets are now stateless

## 1.0.2+1

* Fixed default padding of checkboxes

## 1.0.2

* Fixed changing size/rotate re-draw bug
* BoxShape is not anymore an element of Style
* Added `isEnable` property on multiple widgets
* Refactored the Sample
* Tried support for web & desktop (mac)
* Added surfaceIntensity (for concave / convex)
* Small changes on Neumorphic colors (less dark)
* Removed border (add Neumorphic inside Neumorphic to reproduce)

## 1.0.1

* Improved performances
* Renamed CurrentTheme to UsedTheme in NeumorphicTheme (Dark, Light, System)
* Renamed NeumorphicTheme.getCurrentTheme(context) to NeumorphicTheme.currentTheme(context)
* Fixed flickering effect when theme changes

## 1.0.0+1

* Added missing authors emails

## 1.0.0

* First release of Flutter-Neumorphic
* Added concave/convex/flat/emboss container decoration
* Added a lot of widgets (button, container, radio, checkbox, etc.)
* Added some samples

## 0.0.1

* initial release.