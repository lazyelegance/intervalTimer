import 'package:flutter/material.dart';

import './home.dart';

class TimerApp extends StatelessWidget {
  const TimerApp();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interval Timer',
      home: const MyHomePage(title: 'Timers'),
    );
  }
}
