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

  Future<LogInfo> log(String email, String password) async {
    final http.Response response = await http.post(
      'http://localhost:8081/api/users/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      print("asdfdsaf");
      return LogInfo.fromJson(json.decode(response.body));
    } else {

      throw Exception('Failed');
    }
  }

  bool verifyLogin(String email, String password){

    //log(email, password);

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
                        builder: (context) => MainPage()
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