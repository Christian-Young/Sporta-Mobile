import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget{
  _CreateEvent createState() => _CreateEvent();
}

class _CreateEvent extends State<CreateEvent>{
  final _courseController = TextEditingController();
  final _parsController = TextEditingController();

  // TODO: Create form to input each player
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                    controller: _courseController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Course',
                    )
                )
            ),
            TextField(
                obscureText: true,
                controller: _parsController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pars for each hole',
                )
            ),
            RaisedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('Create Event')
            ),
          ],
        ),
      ),
    );
  }
}
