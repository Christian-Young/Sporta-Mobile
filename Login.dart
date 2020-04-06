import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'Register.dart';

// Create login state / Create the context
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // TODO: Verify email and password are in the db.
  bool verifyLogin(String email, String password){

    // if (email is in the db)
    // if (password is the correct password for the email)
    // return true;
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