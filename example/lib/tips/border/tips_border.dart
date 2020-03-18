import 'package:example/lib/Code.dart';
import 'package:example/lib/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class TipsBorderPage extends StatefulWidget {
  TipsBorderPage({Key key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

Color _textColor(BuildContext context) {
  if (NeumorphicTheme.isUsingDark(context))
    return Colors.white70;
  else {
    return Colors.black;
  }
}

class _WidgetPageState extends State<TipsBorderPage> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      usedTheme: UsedTheme.LIGHT,
      theme: NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        depth: 4,
        intensity: 0.5,
      ),
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      padding: EdgeInsets.all(8),
      child: Scaffold(
        appBar: TopBar(
          title: "IndeterminateProgress",
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _CustomWidget(
                title: "Emboss Inside Flat",
                firstStyle: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  depth: 8,
                ),
                secondStyle: NeumorphicStyle(
                  depth: -8,
                ),
              ),
              _CustomWidget(
                title: "Emboss Inside Convex",
                firstStyle: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  depth: 8,
                ),
                secondStyle: NeumorphicStyle(
                  depth: -8,
                ),
              ),
              _CustomWidget(
                title: "Emboss Inside Concave",
                firstStyle: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  depth: 8,
                ),
                secondStyle: NeumorphicStyle(
                  depth: -8,
                ),
              ),
              _CustomWidget(
                title: "Flat Inside Emboss",
                firstStyle: NeumorphicStyle(
                  depth: -8,
                ),
                secondStyle: NeumorphicStyle(
                  depth: 8,
                  shape: NeumorphicShape.flat,
                ),
              ),
              _CustomWidget(
                title: "Convex Inside Emboss",
                firstStyle: NeumorphicStyle(
                  depth: -8,
                ),
                secondStyle: NeumorphicStyle(
                  depth: 8,
                  shape: NeumorphicShape.convex,
                ),
              ),
              _CustomWidget(
                title: "Concave Inside Emboss",
                firstStyle: NeumorphicStyle(
                  depth: -8,
                ),
                secondStyle: NeumorphicStyle(
                  depth: 8,
                  shape: NeumorphicShape.concave,
                ),
              ),
              _CustomWidget(
                title: "Concave Inside Convex",
                firstStyle: NeumorphicStyle(
                  depth: 8,
                  shape: NeumorphicShape.convex,
                ),
                secondStyle: NeumorphicStyle(
                  depth: 8,
                  shape: NeumorphicShape.concave,
                ),
              ),
              _CustomWidget(
                title: "Convex Inside Concave",
                firstStyle: NeumorphicStyle(
                  depth: 8,
                  shape: NeumorphicShape.concave,
                ),
                secondStyle: NeumorphicStyle(
                  depth: 8,
                  shape: NeumorphicShape.convex,
                ),
              ),
              _EmbossmbossWidget(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomWidget extends StatefulWidget {
  final String title;

  final NeumorphicStyle firstStyle;
  final NeumorphicStyle secondStyle;

  _CustomWidget({@required this.title, @required this.firstStyle, @required this.secondStyle});

  @override
  createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<_CustomWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""

""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(color: _textColor(context)),
          ),
          SizedBox(width: 12),
          Neumorphic(
            padding: EdgeInsets.all(20),
            boxShape: NeumorphicBoxShape.circle(),
            style: widget.firstStyle,
            child: Neumorphic(
              boxShape: NeumorphicBoxShape.circle(),
              style: widget.secondStyle,
              child: SizedBox(
                height: 100,
                width: 100,
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            "opposite\nchild\nlightsource",
            style: TextStyle(color: _textColor(context)),
          ),
          SizedBox(width: 12),
          Neumorphic(
            padding: EdgeInsets.all(20),
            boxShape: NeumorphicBoxShape.circle(),
            style: widget.firstStyle,
            child: Neumorphic(
              boxShape: NeumorphicBoxShape.circle(),
              style: widget.secondStyle.copyWith(oppositeShadowLightSource: true),
              child: SizedBox(
                height: 100,
                width: 100,
              ),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}

class _EmbossmbossWidget extends StatefulWidget {
  @override
  createState() => _EmbossmbossWidgetState();
}

class _EmbossmbossWidgetState extends State<_EmbossmbossWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""

""");
  }

  Widget _generateEmbosss({int number, Widget child, bool reverseEachPair = false}) {
    Widget element = child;
    for(int i=0;i<number;++i){
      element = Neumorphic(
        padding: EdgeInsets.all(20),
        boxShape: NeumorphicBoxShape.circle(),
        style: NeumorphicStyle(
          depth: -8,
          oppositeShadowLightSource: (reverseEachPair && i%2 ==0)
        ),
        child: element,
      );
    }
    return element;
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Emboss\ninside Emboss\ninside Emboss\ninside Emboss",
                style: TextStyle(color: _textColor(context)),
              ),
              SizedBox(width: 12),
              _generateEmbosss(
                number: 5,
                child: SizedBox(
                  height: 10,
                  width: 10,
                ),
              ),
              SizedBox(width: 12),
              Text(
                "Each pair number\nLightsource is reversed",
                style: TextStyle(color: _textColor(context)),
              ),
              SizedBox(width: 12),
              _generateEmbosss(
                number: 5,
                reverseEachPair: true,
                child: SizedBox(
                  height: 10,
                  width: 10,
                ),
              ),
              SizedBox(width: 12),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Text(
                "Emboss\ninside Emboss\ninside Emboss\ninside Emboss",
                style: TextStyle(color: _textColor(context)),
              ),
              SizedBox(width: 12),
              _generateEmbosss(
                number: 4,
                child: SizedBox(
                  height: 10,
                  width: 10,
                ),
              ),
              SizedBox(width: 12),
              Text(
                "Each pair number\nLightsource is reversed",
                style: TextStyle(color: _textColor(context)),
              ),
              SizedBox(width: 12),
              _generateEmbosss(
                number: 4,
                reverseEachPair: true,
                child: SizedBox(
                  height: 10,
                  width: 10,
                ),
              ),
              SizedBox(width: 12),
            ],
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}
