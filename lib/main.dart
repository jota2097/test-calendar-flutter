import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_calendar/components/calendar/flutter_week_view.dart';

import 'package:url_launcher/url_launcher.dart' as launcher;

/// First plugin test method.
void main() async {
  runApp(_FlutterWeekViewDemoApp());
}

/// The demo material app.
class _FlutterWeekViewDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Week View Demo',
        theme: new ThemeData(scaffoldBackgroundColor: Colors.white),
        initialRoute: '/',
        routes: {
          '/': (context) => inScaffold(body: _FlutterWeekViewDemoAppBody()),
          '/day-view': (context) => inScaffold(
                title: 'Demo day view',
                body: _DemoDayView(),
              ),
          '/week-view': (context) => inScaffold(
                title: 'Demo week view',
                body: _DemoWeekView(),
              ),
          '/dynamic-day-view': (context) => _DynamicDayView(),
        },
      );

  static Widget inScaffold({
    String title = 'Flutter Week View',
    required Widget body,
  }) =>
      Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: body,
      );
}

/// The demo app body widget.
class _FlutterWeekViewDemoAppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String github = 'https://github.com/Skyost/FlutterWeekView';
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Text(
                'Flutter Week View demo',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              child: const Text('Demo day view'),
              onPressed: () => Navigator.pushNamed(context, '/day-view'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Demo week view'),
              onPressed: () => Navigator.pushNamed(context, '/week-view'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Demo dynamic day view'),
              onPressed: () =>
                  Navigator.pushNamed(context, '/dynamic-day-view'),
            ),
            const Expanded(
              child: SizedBox.expand(),
            ),
            GestureDetector(
              onTap: () async {
                if (await launcher.canLaunch(github)) {
                  await launcher.launch(github);
                }
              },
              child: Text(
                "github",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue[800],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The demo day view widget.
class _DemoDayView extends StatefulWidget {
  @override
  __DemoDayViewState createState() => __DemoDayViewState();
}

class __DemoDayViewState extends State<_DemoDayView> {
  DateTime now = DateTime.now();
  List<FlutterWeekViewEvent> events = [];
  DateTime date = DateTime.now();
  bool firstTime = false;
  @override
  void initState() {
    super.initState();

    events = [
      FlutterWeekViewEvent(
          title: 'An event 1',
          description: 'A description 12',
          start: date.subtract(const Duration(hours: 24, minutes: 0)),
          end: date.add(const Duration(hours: 1)),
          backgroundColor: Colors.green,
          onTap: () => print("hola")),
      FlutterWeekViewEvent(
          title: 'An event 2',
          description: 'A description 2',
          start: date.add(const Duration(hours: 6)),
          end: date.add(const Duration(hours: 8)),
          backgroundColor: Colors.red),
      FlutterWeekViewEvent(
          title: 'An event 3',
          description: 'A description 3',
          start: date.add(const Duration(hours: 9, minutes: 30)),
          end: date.add(const Duration(hours: 11, minutes: 30)),
          backgroundColor: Colors.purple),
      FlutterWeekViewEvent(
          title: 'An event 4',
          description: 'A description 4',
          start: date.add(const Duration(hours: 20)),
          end: date.add(const Duration(hours: 21)),
          backgroundColor: Colors.pink),
      FlutterWeekViewEvent(
          title: 'An event 5',
          description: 'A description 5',
          start: date.add(const Duration(hours: 20)),
          end: date.add(const Duration(hours: 21)),
          backgroundColor: Colors.yellow),
    ];
  }

  @override
  Widget build(BuildContext context) {
    date = DateTime(now.year, now.month, now.day);
    return DayView(
      initialTime: HourMinute(hour: now.hour, minute: now.minute),
      date: now,
      onChangeDate: onChangeDate,
      events: events,
      style: DayViewStyle.fromDate(
        date: date,
        currentTimeCircleColor: Colors.pink,
      ),
    );
  }

  void onChangeDate(DateTime value) {
    print(value);
    setState(() {
      now = value;
      events = [
        FlutterWeekViewEvent(
            title: 'An event 1',
            description: 'A description 12',
            start: now.subtract(Duration(hours: !firstTime ? 8 : 10)),
            end: now.add(Duration(hours: (!firstTime ? 9 : 11))),
            backgroundColor: !firstTime ? Colors.green : Colors.orange,
            onTap: () => print("hola"))
      ];
      firstTime = true;
    });
  }
}

/// The demo week view widget.
class _DemoWeekView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return WeekView(
      dates: [
        date.subtract(const Duration(days: 1)),
        date,
        date.add(const Duration(days: 1))
      ],
      events: [
        FlutterWeekViewEvent(
            title: 'An event 1',
            description: 'A description 1',
            start: date.subtract(const Duration(hours: 1)),
            end: date.add(const Duration(hours: 18, minutes: 30)),
            backgroundColor: Colors.blueGrey),
        FlutterWeekViewEvent(
            title: 'An event 2',
            description: 'A description 2',
            start: date.add(const Duration(hours: 19)),
            end: date.add(const Duration(hours: 22)),
            backgroundColor: Colors.brown),
        FlutterWeekViewEvent(
            title: 'An event 3',
            description: 'A description 3',
            start: date.add(const Duration(hours: 23, minutes: 30)),
            end: date.add(const Duration(hours: 25, minutes: 30)),
            backgroundColor: Colors.greenAccent),
        FlutterWeekViewEvent(
            title: 'An event 4',
            description: 'A description 4',
            start: date.add(const Duration(hours: 20)),
            end: date.add(const Duration(hours: 21)),
            backgroundColor: Colors.indigo),
        FlutterWeekViewEvent(
            title: 'An event 5',
            description: 'A description 5',
            start: date.add(const Duration(hours: 20)),
            end: date.add(const Duration(hours: 21)),
            backgroundColor: Colors.lightBlue),
      ],
    );
  }
}

/// A day view that displays dynamically added events.
class _DynamicDayView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DynamicDayViewState();
}

/// The dynamic day view state.
class _DynamicDayViewState extends State<_DynamicDayView> {
  /// The added events.
  List<FlutterWeekViewEvent> events = [];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo dynamic day view'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                DateTime start = DateTime(now.year, now.month, now.day,
                    Random().nextInt(24), Random().nextInt(60));
                events.add(FlutterWeekViewEvent(
                    title: 'Event ' + (events.length + 1).toString(),
                    start: start,
                    end: start.add(const Duration(hours: 1)),
                    description: 'A description.',
                    backgroundColor: Colors.red));
              });
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: DayView(
        date: now,
        events: events,
      ),
    );
  }
}
