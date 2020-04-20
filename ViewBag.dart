import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Session.dart';
import 'dart:convert';
import 'dart:async';

class ViewBag extends StatefulWidget{
  final String bagID;

  ViewBag(this.bagID);

  _ViewBag createState() => _ViewBag(bagID);
}

class _ViewBag extends State<ViewBag>{
  final String bagID;

  _ViewBag(this.bagID);

  Future<void> getBag(dynamic info) async {
    final http.Response _response = await http.post(
      'http://localhost3000.us-east-2.elasticbeanstalk.com/api/golf/getGolfBag',
      headers: headers,
      body: info
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
    getBag(jsonEncode(<String, String>{
      'bid': bagID,
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Bag'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text("Bag")
            ),
            Text("Club"),
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
