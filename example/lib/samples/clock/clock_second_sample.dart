import 'package:example/lib/top_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ClockAlarmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
          defaultTextColor: Color(0xFF303E57),
          accentColor: Color(0xFF7B79FC),
          variantColor: Colors.black38,
          baseColor: Color(0xFFF8F9FC),
          depth: 8,
          intensity: 0.5,
          lightSource: LightSource.topLeft),
      themeMode: ThemeMode.light,
      child: Material(
        child: NeumorphicBackground(
          child: _Page(),
        ),
      ),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  createState() => _ClockPageState();
}

class _ClockPageState extends State<_Page> {
  final List<Alarm> items = [
    Alarm(
      enabled: true,
      time: "8:30 AM",
      label: "Awake !",
    ),
    Alarm(
      enabled: false,
      time: "8:45 AM",
      label: "Wake up !",
    ),
    Alarm(
      enabled: false,
      time: "9:00 AM",
      label: "Hurry up !",
    ),
    Alarm(
      enabled: false,
      time: "2:00 AM",
      label: "Lunchtime",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 9.0),
            child: TopBar(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Alarm",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      shadows: [
                        Shadow(
                            color: Colors.black38,
                            offset: Offset(1.0, 1.0),
                            blurRadius: 2)
                      ],
                      color: NeumorphicTheme.defaultTextColor(context),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      depth: 20,
                      intensity: 0.4,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8)),
                    ),
                    child: NeumorphicButton(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.add,
                        color: Color(0xFFC1CDE5),
                      ),
                      style: NeumorphicStyle(
                        depth: -1,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _Divider(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return AlarmCell(this.items[index]);
              },
              itemCount: items.length,
            ),
          )
        ],
      ),
    );
  }
}

class AlarmCell extends StatelessWidget {
  final Alarm alarm;

  AlarmCell(this.alarm);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      alarm.time,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                        shadows: [
                          Shadow(
                              color: Colors.black38,
                              offset: Offset(1.0, 1.0),
                              blurRadius: 2)
                        ],
                        color: NeumorphicTheme.defaultTextColor(context),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      alarm.label,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: NeumorphicTheme.variantColor(context),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          depth: 8,
                          intensity: 0.5,
                          boxShape: NeumorphicBoxShape.stadium(),
                        ),
                        child: NeumorphicSwitch(
                          style: NeumorphicSwitchStyle(
                              inactiveTrackColor: Color(0xffC1CDE5)),
                          height: 30,
                          value: alarm.enabled,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _Divider(),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Neumorphic(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        style: NeumorphicStyle(
          depth: -4,
          boxShape: NeumorphicBoxShape.stadium(),
        ),
        child: SizedBox(
          height: 6,
        ),
      ),
    );
  }
}

class Alarm {
  final bool enabled;
  final String time;
  final String label;

  const Alarm({
    required this.enabled,
    required this.time,
    required this.label,
  });
}
