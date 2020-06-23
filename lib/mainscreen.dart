import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_clock/get_time.dart';
import 'package:web_clock/particles.dart';
import 'package:web_clock/themes.dart';
import 'constants.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Themes theme = Themes();

  Icon themeIcon() {
    if (val == 0) {
      return Icon(Icons.brightness_7);
    } else {
      return Icon(Icons.brightness_3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme.getThemeWidget(),
      home: Scaffold(
        // backgroundColor: Colors.grey[850],
        body: Stack(
          children: [
            Particles(
              35, // Number of Particles
              Colors.blue[300], // Color of Particles
            ),
            Particles(
              35, // Number of Particles
              Colors.red, // Color of Particles
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CenterCard(),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: IconButton(
                        icon: themeIcon(),
                        onPressed: () {
                          setState(() {
                            val == 0 ? val = 1 : val = 0;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CenterCard extends StatefulWidget {
  const CenterCard({
    Key key,
  }) : super(key: key);

  @override
  _CenterCardState createState() => _CenterCardState();
}

class _CenterCardState extends State<CenterCard> {
  GetTime instance = GetTime();
  // String time = 'Loading...';
  String hour = '00';
  String min = '00';
  String sec = '00';
  int day = 00;

  Future<void> getTime() async {
    await instance.getData();
    hour = instance.hour;
    min = instance.min;
    sec = instance.sec;
    day = instance.day;
    setState(() {}); // to load the card every second after api calls for clock to update per sec..
  }

  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getTime();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.6,
      color: val == 0 ? Colors.white : Color(0xFF121212),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: RowTime(day: day, hour: hour, min: min, sec: sec),
        ),
      ),
    );
  }
}

class RowTime extends StatelessWidget {
  const RowTime({
    Key key,
    @required this.day,
    @required this.hour,
    @required this.min,
    @required this.sec,
  }) : super(key: key);

  final int day;
  final String hour;
  final String min;
  final String sec;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day == 1
                  ? 'MO'
                  : day == 2
                      ? 'TU'
                      : day == 3
                          ? 'WE'
                          : day == 4
                              ? 'TH'
                              : day == 5
                                  ? 'FR'
                                  : day == 6 ? 'SA' : day == 7 ? 'SU' : '00',
              style: TextStyle(
                color: val == 0 ? Color(0xFF121212) : Colors.white,
                fontSize: 90,
              ),
            ),
            Text(
              'Day',
              style: TextStyle(
                color: val == 0 ? Color(0xFF121212) : Colors.grey[350],
                fontSize: 15,
              ),
            ),
          ],
        ),
        Text(
          ':',
          style: TextStyle(
            color: val == 0 ? Color(0xFF121212) : Colors.grey[350],
            fontSize: 50,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hour,
              style: TextStyle(
                color: val == 0 ? Color(0xFF121212) : Colors.white,
                fontSize: 90,
              ),
            ),
            Text(
              'Hours',
              style: TextStyle(
                color: val == 0 ? Color(0xFF121212) : Colors.grey[350],
                fontSize: 15,
              ),
            ),
          ],
        ),
        Text(
          ':',
          style: TextStyle(
            color: val == 0 ? Color(0xFF121212) : Colors.grey[350],
            fontSize: 50,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              min,
              style: TextStyle(
                color: val == 0 ? Color(0xFF121212) : Colors.white,
                fontSize: 90,
              ),
            ),
            Text(
              'Minutes',
              style: TextStyle(
                color: val == 0 ? Color(0xFF121212) : Colors.grey[350],
                fontSize: 15,
              ),
            ),
          ],
        ),
        Text(
          ':',
          style: TextStyle(
            color: val == 0 ? Color(0xFF121212) : Colors.grey[350],
            fontSize: 50,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sec,
              style: TextStyle(
                color: val == 0 ? Color(0xFF121212) : Colors.white,
                fontSize: 90,
              ),
            ),
            Text(
              'Seconds',
              style: TextStyle(
                color: val == 0 ? Color(0xFF121212) : Colors.grey[350],
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
