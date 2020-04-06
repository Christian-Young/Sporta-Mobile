import 'package:flutter/material.dart';

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
  // TODO: If all credentials are valid, put them in the db and assure the user they are now registered.
  bool verifyRegistration(String firstName, String lastName, String email, String password, BuildContext context){

    if (firstName.length == 0 || lastName.length == 0 || email.length == 0 || password.length == 0){
      _showDialog(context, "Please fill in all fields.");
      return false;
    }
    else if (password.length < 5){
      _showDialog(context, "Password too short.");
      return false;
    }

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
                  };
                },
                child: Text('Register')
            ),
          ],
        ),
      ),
    );
  }
}
