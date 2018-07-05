import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:async';

class TimerText extends StatefulWidget {
  final DateTime startTime;
  final TextStyle textStyle;

  const TimerText(
      {@required this.startTime,
      this.textStyle = const TextStyle(fontSize: 30.0)})
      : assert(startTime != null);

  @override
  _TimerTextState createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> with TickerProviderStateMixin {
  startTimeout([int milliseconds]) {
    const timeout = const Duration(seconds: 3);
    const ms = const Duration(milliseconds: 1);
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    // callback function
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  _daysString(int days) {
    return days == 1 ? 'd' : 'd';
  }

  @override
  Widget build(BuildContext context) {
    startTimeout(5000);
    var now = new DateTime.now();
    var difference = now.difference(widget.startTime);
    var finalTimeToDisplay = '0';

    if (difference.inDays == 0 && difference.inHours == 0) {
      finalTimeToDisplay =
          '${(difference.inMinutes - 60*difference.inHours).toString().padLeft(2, '0')}:${(difference.inSeconds - difference.inMinutes* 60).toString().padLeft(2, '0')}';
    } else if (difference.inDays == 0) {
      finalTimeToDisplay =
          '${(difference.inHours).toString()}:${(difference.inMinutes - 60*difference.inHours).toString().padLeft(2, '0')}:${(difference.inSeconds - difference.inMinutes* 60).toString().padLeft(2, '0')}';
    } else {
      finalTimeToDisplay =
          '${(difference.inDays).toString()}${_daysString(difference.inDays)}+ ${(difference.inHours - 24*difference.inDays).toString()}:${(difference.inMinutes - 60*difference.inHours).toString().padLeft(2, '0')}:${(difference.inSeconds - difference.inMinutes* 60).toString().padLeft(2, '0')}';
    }

    return Text(
      finalTimeToDisplay,
      style: widget.textStyle,
    );
  }
}
