import 'package:example/tips/tips_home.dart';
import 'package:example/widgets/widgets_home.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'accessibility/neumorphic_accessibility.dart';
import 'playground/neumorphic_playground.dart';
import 'playground/text_playground.dart';
import 'samples/sample_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: 'Flutter Neumorphic',
      home: FullSampleHomePage(),
    );
  }
}

class FullSampleHomePage extends StatelessWidget {
  Widget _buildButton({required String text, required VoidCallback onClick}) {
    return NeumorphicButton(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
        //border: NeumorphicBorder(
        //  isEnabled: true,
        //  width: 0.3,
        //),
        shape: NeumorphicShape.flat,
      ),
      child: Center(child: Text(text)),
      onPressed: onClick,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(depth: 8),
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildButton(
                    text: "Neumorphic Playground",
                    onClick: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return NeumorphicPlayground();
                      }));
                    },
                  ),
                  SizedBox(height: 24),
                  _buildButton(
                    text: "Text Playground",
                    onClick: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return NeumorphicTextPlayground();
                      }));
                    },
                  ),
                  SizedBox(height: 24),
                  _buildButton(
                      text: "Samples",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SamplesHome();
                        }));
                      }),
                  SizedBox(height: 24),
                  _buildButton(
                      text: "Widgets",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return WidgetsHome();
                        }));
                      }),
                  SizedBox(height: 24),
                  _buildButton(
                      text: "Tips",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return TipsHome();
                        }));
                      }),
                  SizedBox(height: 24),
                  _buildButton(
                      text: "Accessibility",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return NeumorphicAccessibility();
                        }));
                      }),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
