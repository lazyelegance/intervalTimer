import 'package:flutter/material.dart';

import './timer.dart';

class TimerCard extends StatelessWidget {
  final String name;
  final DateTime startTime;
  final VoidCallback resetAction;
  final VoidCallback deleteAction;

  const TimerCard(
      {this.name, this.startTime, this.deleteAction, this.resetAction})
      : assert(name != null),
        assert(startTime != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.timelapse,
                    size: 30.0,
                    color: Colors.amber,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new Text(name),
                      SizedBox(height: 5.0),
                      TimerText(
                          startTime: startTime,
                          textStyle: TextStyle(fontSize: 20.0))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        children: <Widget>[
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: const Text('RESET'),
                  onPressed: () {
                    resetAction();
                  },
                ),
                new FlatButton(
                  child: const Text(
                    'DELETE',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  onPressed: () async {
                    deleteAction();
                  },
                ),
              ],
            ),
          )
        ],
        trailing: Container(
          width: 0.0,
          height: 0.0,
        ),
      ),
    );
  }
}
