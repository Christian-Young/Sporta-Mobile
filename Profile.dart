import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                  )
                )
              ),
            ]
        )
      )
    );
  }
}