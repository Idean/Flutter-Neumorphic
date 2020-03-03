import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AudioPlayerSample extends StatefulWidget {
  @override
  _AudioPlayerSampleState createState() => _AudioPlayerSampleState();
}

class _AudioPlayerSampleState extends State<AudioPlayerSample> {

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      currentTheme: CurrentTheme.LIGHT,
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFDDE6E8),
        intensity: 0.5,
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      child: _Page()
    );
  }
}

class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> {

  bool _useDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NeumorphicBackground(
          child: Column(
            children: <Widget>[
              SizedBox(height: 14),
              _buildTopBar(context),
              SizedBox(height: 80),
              _buildImage(context),
              SizedBox(height: 30),
              _buildTitle(context),
              SizedBox(height: 30),
              _buildSeekBar(context),
              SizedBox(height: 30),
              _buildControlsBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: NeumorphicButton(
              onClick: () {
                Navigator.of(context).pop();
              },
              style: NeumorphicStyle(shape: NeumorphicShape.flat),
              boxShape: NeumorphicBoxShape.circle(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.navigate_before,
                  color: _iconsColor(),
                ),
              ),
            ),
          ),
          Align(alignment: Alignment.center, child: Text("Now Playing")),
          Align(
            alignment: Alignment.centerRight,
            child: NeumorphicButton(
              onClick: () {
                setState(() {
                  _useDark = !_useDark;
                  NeumorphicTheme.of(context).setCurrentTheme(_useDark ? CurrentTheme.DARK : CurrentTheme.LIGHT);
                });
              },
              style: NeumorphicStyle(shape: NeumorphicShape.flat),
              boxShape: NeumorphicBoxShape.circle(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.favorite_border,
                  color: _iconsColor(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.circle(),
      child: Container(
          height: 200,
          width: 200,
          child: Image.asset(
            "assets/images/weeknd.jpg",
            fit: BoxFit.fill,
          )),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("Blinding Lights", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 34, color: _textsColor())),
        const SizedBox(
          height: 4,
        ),
        Text("The Weeknd", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: _textsColor())),
      ],
    );
  }

  Widget _buildSeekBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "2.00",
                    style: TextStyle(color: _textsColor()),
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "3.14",
                    style: TextStyle(color: _textsColor()),
                  )),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          NeumorphicSlider(
            height: 8,
            min: 0,
            max: 314,
            value: 100,
            onChanged: (value) {},
          )
        ],
      ),
    );
  }

  Widget _buildControlsBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        NeumorphicButton(
          onClick: () {},
          style: NeumorphicStyle(shape: NeumorphicShape.flat),
          boxShape: NeumorphicBoxShape.circle(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.skip_previous,
              color: _iconsColor(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        NeumorphicButton(
          onClick: () {},
          style: NeumorphicStyle(shape: NeumorphicShape.flat),
          boxShape: NeumorphicBoxShape.circle(),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Icon(
              Icons.play_arrow,
              size: 42,
              color: _iconsColor(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        NeumorphicButton(
          onClick: () {},
          style: NeumorphicStyle(shape: NeumorphicShape.flat),
          boxShape: NeumorphicBoxShape.circle(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.skip_next,
              color: _iconsColor(),
            ),
          ),
        ),
      ],
    );
  }

  Color _iconsColor() {
    final theme = NeumorphicTheme.of(context);
    if (theme.isUsingDark()) {
      return theme.current.accentColor;
    } else {
      return null;
    }
  }

  Color _textsColor() {
    final theme = NeumorphicTheme.of(context);
    if (theme.isUsingDark()) {
      return Colors.white70;
    } else {
      return Color(0xFF3E3E3E);
    }
  }
}
