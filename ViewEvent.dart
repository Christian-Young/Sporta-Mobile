import 'package:flutter/material.dart';

class ViewEvent extends StatefulWidget{
  _ViewEvent createState() => _ViewEvent();
}

class _ViewEvent extends State<ViewEvent>{
  final _courseController = TextEditingController();
  final _parsController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Event'),
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
                child: Text('Back')
            ),
          ],
        ),
      ),
    );
  }
}
