import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTimerDialog extends StatefulWidget {
  @override
  AddTimerDialogState createState() {
    return new AddTimerDialogState();
  }
}

class AddTimerDialogState extends State<AddTimerDialog> {
  final _timeNameController = TextEditingController();

  DateTime _timerStartDate = new DateTime.now();
  String _timerName = '';

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();

    return new AlertDialog(
      title: new Text("Add a timer"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _timeNameController,
            onChanged: (value) {
              setState(() {
                _timerName = value;
              });
            },
            decoration: InputDecoration(
              filled: true,
              labelText: 'timer name',
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.blue,
                        onPressed: () async {
                          DateTime datePicked;
                          TimeOfDay timePicked;
                          datePicked = await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: now.subtract(new Duration(days: 30)),
                              lastDate: now,
                              initialDatePickerMode: DatePickerMode.day);
                          if (datePicked != null) {
                            timePicked = await showTimePicker(
                              context: context,
                              initialTime: new TimeOfDay.now(),
                            );
                            setState(() {
                              _timerStartDate = datePicked
                                  .add(new Duration(hours: timePicked.hour))
                                  .add(
                                      new Duration(minutes: timePicked.minute));
                            });
                          }
                        },
                        child: Text(
                          new DateFormat.yMMMd()
                              .add_Hm()
                              .format(_timerStartDate)
                              .toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            _timerStartDate = now;
                          });
                        },
                        icon: Icon(Icons.restore),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                padding: EdgeInsets.all(8.0),
                onPressed: _timerName != ''
                    ? () {
                        Navigator.pop(context,
                            {"name": _timerName, "startTime": _timerStartDate});
                      }
                    : null,
                child: Text('ADD'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
