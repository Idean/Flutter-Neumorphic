import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AudioPlayerSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicThemeProvider(
      theme: NeumorphicTheme(
        intensity: 0.8,
          lightSource: LightSource.topLeft,
          depth: 10
      ),
      child: Scaffold(
        body: SafeArea(
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
              shape: NeumorphicBoxShape.circle(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.navigate_before),
              ),
            ),
          ),
          Align(alignment: Alignment.center, child: Text("Now Playing")),
          Align(
            alignment: Alignment.centerRight,
            child: NeumorphicButton(
              style: NeumorphicStyle(shape: NeumorphicShape.flat),
              shape: NeumorphicBoxShape.circle(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.favorite_border),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Neumorphic(
      shape: NeumorphicBoxShape.circle(),
      child: Container(
        height: 200,
        width: 200,
        child: Image.asset("assets/images/aya.jpg", fit: BoxFit.fill,)
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("Pookie", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 34, color: Color(0xFF3E3E3E))),
        const SizedBox(height: 4,),
        Text("Aya Nakamura", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF3E3E3E))),
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
              Align(alignment: Alignment.centerLeft, child: Text("2.00")),
              Align(alignment: Alignment.centerRight, child: Text("3.14")),
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
          onClick: (){

          },
          style: NeumorphicStyle(shape: NeumorphicShape.flat),
          shape: NeumorphicBoxShape.circle(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.skip_previous),
          ),
        ),
        const SizedBox(width: 12),
        NeumorphicButton(
          onClick: (){

          },
          style: NeumorphicStyle(shape: NeumorphicShape.flat),
          shape: NeumorphicBoxShape.circle(),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Icon(
              Icons.play_arrow,
              size: 42,
            ),
          ),
        ),
        const SizedBox(width: 12),
        NeumorphicButton(
          onClick: (){

          },
          style: NeumorphicStyle(shape: NeumorphicShape.flat),
          shape: NeumorphicBoxShape.circle(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.skip_next),
          ),
        ),
      ],
    );
  }
}
