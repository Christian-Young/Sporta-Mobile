import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  // Text controllers for the profile information fields
  final _firstNameController = TextEditingController(text: 'first name init');
  final _lastNameController = TextEditingController(text: 'last name init');
  final _emailController = TextEditingController(text: 'email init');
  final _heightController = TextEditingController(text: 'height init');
  final _ageController = TextEditingController(text: 'age init');

  // Keyboard focus nodes for each field
  List<FocusNode> _nodes = [new FocusNode(), new FocusNode(), new FocusNode(),
                            new FocusNode(), new FocusNode()];

  // ReadOnly booleans for each field
  List<bool> _ReadOnlybools = [true, true, true, true, true];

  // Dialog box
  void _showDialog(BuildContext context, String message, int enable){
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
                        _showDialog(context, "Edit first name?", 0);
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
                          _showDialog(context, "Edit last name?", 1);
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
                          _showDialog(context, "Edit email?", 2);
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
                          _showDialog(context, "Edit height?", 3);
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
                          _showDialog(context, "Edit age?", 4);
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
            ]
        )
      )
    );
  }
}