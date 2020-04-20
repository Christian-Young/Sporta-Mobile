import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Session.dart';
import 'dart:async';

class ViewMatch extends StatefulWidget{
  final String matchID;

  ViewMatch(this.matchID);

  _ViewMatch createState() => _ViewMatch(matchID);
}

class _ViewMatch extends State<ViewMatch>{
  final String matchID;

  _ViewMatch(this.matchID);

  Future<void> getMatch() async {
    final http.Response _response = await http.get(
      'http://localhost3000.us-east-2.elasticbeanstalk.com/api/golf/getGolfMatch/$matchID',
      headers: headers,
    );

    if (_response.statusCode == 200) {
      print(_response.body);
    }
    else {
      print(_response.statusCode);
      print(_response.body);
    }
  }

  void initState(){
    super.initState();
    getMatch();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Match'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text("Match")
            ),
            Text("Stuff"),
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
