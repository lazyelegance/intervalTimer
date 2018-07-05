import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './timercard.dart';
import './addtimerdialog.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  addNewTimer(String name, DateTime startTime) {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('counters');
      await reference.add({"name": name, "startTime": startTime});
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    var startTime = document['startTime'];

    return new ListTile(
      key: new ValueKey(document.documentID),
      title: _buildCard(document['name'], startTime),
    );
  }

  Widget _buildCard(String name, startTime) {
    return TimerCard(
      name: name,
      startTime: startTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text(title)),
      body: new StreamBuilder(
          stream: Firestore.instance.collection('counters').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.only(top: 10.0),
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data.documents[index]));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var timerDetails =
              await showDialog(context: context, builder: _buildAddTimerDialog);
          print(timerDetails['name']);
          if (timerDetails != null && timerDetails['name'] != '') {
            addNewTimer(timerDetails['name'], timerDetails['startTime']);
          }
        },
        child: Icon(Icons.add_alarm),
      ),
    );
  }

  Widget _buildAddTimerDialog(BuildContext context) {
    return AddTimerDialog();
  }
}

// onTap: () => Firestore.instance.runTransaction((transaction) async {
//       DocumentSnapshot freshSnap =
//           await transaction.get(document.reference);
//       await transaction
//           .update(freshSnap.reference, {'votes': freshSnap['votes'] + 1});
//     }),
// new Text(document['name'])

// TimerText(
//               startTime: startTime,
//             )
