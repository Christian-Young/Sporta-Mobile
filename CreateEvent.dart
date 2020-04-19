import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/EventInfo.dart';
import 'Session.dart';
import 'dart:convert';
import 'dart:async';


class CreateEvent extends StatefulWidget{
  _CreateEvent createState() => _CreateEvent();
}

class _CreateEvent extends State<CreateEvent>{
  final _titleController = TextEditingController();
  final _courseController = TextEditingController();
  final _holeController = TextEditingController();
  List<TextEditingController> _parsController;
  List<Widget> _holeList;
  List<Widget> _playerList;
  List<TextEditingController> _controllerList;
  String _numPlayers = '1';

  Future<EventInfo> event(dynamic info) async {
    final http.Response _response = await http.post(
      'http://localhost3000.us-east-2.elasticbeanstalk.com/api/golf/createGolfEvent',
      headers: headers,
      body: info
    );

    if (_response.statusCode == 200) {
      //return EventInfo.fromJson(json.decode(_response.body));
    }
    else {
      print(_response.statusCode);
      print(_response.body);
    }
  }

  void createHoles(int holeCount){
    _parsController = new List<TextEditingController>(holeCount);
    _holeList = new List<Widget>();

    for (int i = 0; i < holeCount; i++)
    {
      setState(() {
        _holeList.add(Expanded(
          child: Container(
            width: 70.0,
            child: TextField(
                style: TextStyle(
                    fontSize: 18
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: (i+1).toString(),
                )
            ),
          )
        )
        );
      });
    }
  }

  Text areParsDisplayed(){
    if(_holeController.text != '')
    {
      if (int.parse(_holeController.text) > 0)
        return new Text("Pars:", textAlign: TextAlign.center, style: TextStyle(fontSize: 17));
      else
        return new Text("");
    }
    else
      return new Text("");
  }

  Row parsForEachHole(){
    if (_holeController.text == '')
      return new Row();

    if (_holeList != null)
    {
        return new Row(children: _holeList);
    }
    else
      return new Row();
  }

  Row displayPlayers(int playerCount){
    _controllerList = new List<TextEditingController>();
    _playerList = new List<Widget>();

    for (int i = 0; i < playerCount; i++){
      _controllerList.add(new TextEditingController());

      _playerList.add(
          Expanded(child: TextField(
            controller: _controllerList[i],
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: "Player Email")
          )
        )
      );
    }
    return Row(children: _playerList);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    )
                )
            ),
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
            Container(
              width: 70.0,
              child: TextField(
                style: TextStyle(
                  fontSize: 17
                ),
                textAlign: TextAlign.center,
                  controller: _holeController,
                  onSubmitted: (_holeController) {
                    setState(() {
                      createHoles(int.parse(_holeController));
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Holes',
                  )
              ),
            ),
            areParsDisplayed(),
            parsForEachHole(),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text("Players:", textAlign: TextAlign.center ,style: TextStyle(fontSize: 20)),
            ),
            displayPlayers(int.parse(_numPlayers)),
            Center(
              child: DropdownButton<String>(
                value: _numPlayers,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color:Colors.deepOrange),
                onChanged: (String newValue) {
                  setState(() {
                    _numPlayers = newValue;
                  });
                },
                items: <String> ['1', '2', '3', '4'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontSize: 18)),
                  );
                }).toList(),
              ),
            ),
            Align(
              child: RaisedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('Create Event')
              ),
            )
          ],
        ),
      ),
    );
  }
}
