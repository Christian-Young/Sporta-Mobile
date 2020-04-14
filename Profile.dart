import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/UserInfo.dart';
import 'Session.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<UserInfo> FutureProfileInfo = user();

  static Future<UserInfo> user() async {
    final http.Response _response = await http.get(
      'http://localhost3000.us-east-2.elasticbeanstalk.com/api/users/detail/get',
      headers: headers,
    );

    if (_response.statusCode == 200) {
      // Return the future of the _response.
      //return UserInfo.fromJson(json.decode(_response.body));
    } else {
      print(_response.statusCode);
      print(_response.body);
    }
  }

  // Text controllers for the profile information fields
  final _firstNameController = TextEditingController(text: 'first name init');
  final _lastNameController = TextEditingController(text: 'last name init');
  final _emailController = TextEditingController(text: 'email init');
  final _heightController = TextEditingController(text: 'height init');
  final _ageController = TextEditingController(text: 'age init');
  final _weightController = TextEditingController(text: 'weight init');

  // Keyboard focus nodes for each field
  List<FocusNode> _nodes = [new FocusNode(), new FocusNode(), new FocusNode(),
                            new FocusNode(), new FocusNode(), new FocusNode()];

  // ReadOnly booleans for each field
  List<bool> _ReadOnlybools = [true, true, true, true, true, true];

  // Dialog box
  void _showDialog(String message, int enable){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
              title: new Text(message),
              actions: <Widget>[
                new FlatButton(
                    child: new Text("Yes"),
                    onPressed: (){
                      _ReadOnlybools[enable] = false;
                      Navigator.of(context).pop();
                    }
                ),
                new FlatButton(
                  child: new Text("Cancel"),
                  onPressed: (){
                    _ReadOnlybools[enable] = true;
                    Navigator.of(context).pop();
                    },
                )
              ]
          );
        }
    );
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: Text('Profile')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextField(
                    onTap: (){
                      setState((){
                        _showDialog("Edit first name?", 0);
                        FocusScope.of(context).requestFocus(_nodes.elementAt(0));
                      });
                    },
                    // Sets the field back to read-only
                    onSubmitted: (a){setState(() {_ReadOnlybools[0] = true;});},
                    focusNode: _nodes.elementAt(0),
                    readOnly: _ReadOnlybools.elementAt(0),
                    controller: _firstNameController,
                    decoration: InputDecoration(
                    suffixIcon: Icon(Icons.create),
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                  )
                )
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                      onTap: () {
                        setState(() {
                          _showDialog("Edit last name?", 1);
                          FocusScope.of(context).requestFocus(_nodes.elementAt(1));
                        });
                      },
                      // Set the field back to read-only
                      onSubmitted: (b){setState(() {_ReadOnlybools[1] = true;});},
                      focusNode: _nodes.elementAt(1),
                      readOnly: _ReadOnlybools.elementAt(1),
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.create),
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                      )
                  )
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                      onTap: () {
                        setState((){
                          _showDialog("Edit email?", 2);
                          FocusScope.of(context).requestFocus(_nodes.elementAt(2));
                        });
                      },
                      // Sets the field back to read-only
                      onSubmitted: (c){setState(() {_ReadOnlybools[2] = true;});},
                      focusNode: _nodes.elementAt(2),
                      readOnly: _ReadOnlybools.elementAt(2),
                      controller: _emailController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.create),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      )
                  )
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                      onTap: () {
                        setState(() {
                          _showDialog("Edit height?", 3);
                          FocusScope.of(context).requestFocus(_nodes.elementAt(3));
                        });
                      },
                      // Sets the field back to read-only
                      onSubmitted: (d){setState(() {_ReadOnlybools[3] = true;});},
                      focusNode: _nodes.elementAt(3),
                      readOnly: _ReadOnlybools.elementAt(3),
                      controller: _heightController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.create),
                        border: OutlineInputBorder(),
                        labelText: 'Height',
                      )
                  )
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                      onTap: () {
                         setState(() {
                          _showDialog("Edit age?", 4);
                          FocusScope.of(context).requestFocus(_nodes.elementAt(4));
                        });
                      },
                      // Sets the field back to read-only
                      onSubmitted: (e){setState(() {_ReadOnlybools[4] = true;});},
                      focusNode: _nodes.elementAt(4),
                      readOnly: _ReadOnlybools.elementAt(4),
                      controller: _ageController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.create),
                        border: OutlineInputBorder(),
                        labelText: 'Age',
                      )
                  )
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                      onTap: () {
                        setState(() {
                          _showDialog("Edit weight?", 5);
                          FocusScope.of(context).requestFocus(_nodes.elementAt(5));
                        });
                      },
                      // Sets the field back to read-only
                      onSubmitted: (e){setState(() {_ReadOnlybools[5] = true;});},
                      focusNode: _nodes.elementAt(5),
                      readOnly: _ReadOnlybools.elementAt(5),
                      controller: _weightController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.create),
                        border: OutlineInputBorder(),
                        labelText: 'Weight',
                      )
                  )
              ),
            ]
        )
      )
    );
  }
}