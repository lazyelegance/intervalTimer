import 'package:flutter/material.dart';

class AddTimerDialog extends StatefulWidget {
  @override
  AddTimerDialogState createState() {
    return new AddTimerDialogState();
  }
}

class AddTimerDialogState extends State<AddTimerDialog> {
  final _timeNameController = TextEditingController();

  DateTime _timerStartDate = new DateTime.now();

  bool _groupValue = true;

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
            decoration: InputDecoration(
              filled: true,
              labelText: 'timer name',
            ),
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('start with current time'),
              Checkbox(
                value: _groupValue,
                onChanged: (val) async {
                  DateTime datePicked;
                  TimeOfDay timePicked;
                  setState(() {
                    _groupValue = val;
                  });
                  if (!val) {
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
                            .add(new Duration(minutes: timePicked.minute));
                      });
                    }
                  } else {
                    setState(() {
                      _timerStartDate = new DateTime.now();
                    });
                  }
                },
              ),
            ],
          ),
          Text(_timerStartDate.toString()),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                padding: EdgeInsets.all(8.0),
                onPressed: _timeNameController.value.text != ''
                    ? () {
                        Navigator.pop(context, {
                          "name": _timeNameController.value.text,
                          "startTime": _timerStartDate
                        });
                      }
                    : null,
                child: Text('DONE'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
