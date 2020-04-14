import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/RegInfo.dart';
import 'dart:async';
import 'dart:convert';

class Register extends StatefulWidget{
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>{
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future<RegInfo> FutureRegInfo;
  http.Response _response;

  // Dialog box
  void _showDialog(BuildContext context, String message){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
              title: new Text(message),
              actions: <Widget>[
                new FlatButton(
                    child: new Text("Close"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }

  Future<RegInfo> reg(String firstname, String lastname, String email, String password) async {
    _response = await http.post(
      'http://localhost3000.us-east-2.elasticbeanstalk.com/api/users/register',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
      }),
    );

    if (_response.statusCode == 200){
      return RegInfo.fromJson(json.decode(_response.body));
    }

    else if (_response.statusCode == 400) {
      _showDialog(context, "Failed to register.");
    }
    else {
        print(_response.statusCode);
        print(_response.body);
    }
  }

  bool verifyRegistration(String firstname, String lastname, String email, String password, BuildContext context){

    // Checks if all fields are filled in.
    if (firstname.length == 0 || lastname.length == 0 || email.length == 0 || password.length == 0){
      _showDialog(context, "Please fill in all fields.");
      return false;
    }

    // Register API call.
    FutureRegInfo = reg(firstname, lastname, email, password);

    return (_response.statusCode == 200);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sporta'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                    )
                )
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                    )
                )
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email',
                    )
                )
            ),
            TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password',
                )
            ),
            RaisedButton(
                onPressed: () {
                  if (verifyRegistration(_firstNameController.text, _lastNameController.text,
                      _emailController.text, _passwordController.text, context)) {
                    Navigator.pop(context);
                    _showDialog(context, "Account created!");
                  }
                },
                child: Text('Register')
            ),
          ],
        ),
      ),
    );
  }
}
