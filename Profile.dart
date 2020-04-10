import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _firstNameController = TextEditingController(text: 'first name init');
  final _lastNameController = TextEditingController(text: 'last name init');
  final _emailController = TextEditingController(text: 'email init');
  final _heightController = TextEditingController(text: 'height init');
  final _ageController = TextEditingController(text: 'age init');

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
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      )
                  )
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                      controller: _heightController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Height',
                      )
                  )
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Age',
                      )
                  )
              ),
            ]
        )
      )
    );
  }
}