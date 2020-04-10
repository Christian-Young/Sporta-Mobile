import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/RegInfo.dart';
import 'dart:async';
import 'dart:convert';

class Register extends StatelessWidget{
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Dialog box
  void _showDialog(BuildContext context, String text){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
              title: new Text(text),
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
    final http.Response response = await http.post(
      'http://localhost:8081/api/users/register',
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
    if (response.statusCode == 200) {
      print("Registration successful");
      return RegInfo.fromJson(json.decode(response.body));
    } else {

      throw Exception('Failed');
    }
  }

  bool verifyRegistration(String firstname, String lastname, String email, String password, BuildContext context){

    if (firstname.length == 0 || lastname.length == 0 || email.length == 0 || password.length == 0){
      _showDialog(context, "Please fill in all fields.");
      return false;
    }
    else if (password.length < 5){
      _showDialog(context, "Password too short.");
      return false;
    }

    // Register
    //reg(firstname, lastname, email, password);

    return true;
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
