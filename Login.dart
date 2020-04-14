import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'Register.dart';
import 'models/LogInfo.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Create login state / Create the context
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future<LogInfo> FutureLogInfo;
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

  Future<LogInfo> log(String email, String password) async {
    _response = await http.post(
        'http://localhost3000.us-east-2.elasticbeanstalk.com/api/users/login',
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (_response.statusCode == 200) {
      return LogInfo.fromJson(json.decode(_response.body));
    }
    else if (_response.statusCode == 400) {
      _showDialog(context, "Incorrect credentials.");
    }
    else {
      print(_response.statusCode);
      print(_response.body);
    }
  }

  bool verifyLogin(String email, String password){

    // Checks if all fields are filled in.
    if (email.length == 0 || password.length == 0){
      _showDialog(context, "Please fill in all fields.");
      return false;
    }

    // Login API call.
    FutureLogInfo = log(email, password);

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
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    )
                )
            ),
            TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                )
            ),
            RaisedButton(
                onPressed: (){
                  if (verifyLogin(_emailController.text, _passwordController.text)){
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => Homepage()
                    )
                    );
                  }
                },
                child: Text('Login')
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                child: Text('Don\'t have an account?')
            ),
            RaisedButton(
                onPressed: (){
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => Register()));
                },
                child: Text('Register')
            ),
          ],
        ),
      ),
    );
  }
}