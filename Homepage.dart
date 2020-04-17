import 'package:flutter/material.dart';
import 'Profile.dart';
import 'CreateEvent.dart';
import 'package:http/http.dart' as http;
import 'models/UserInfo.dart';
import 'Session.dart';
import 'dart:convert';
import 'dart:async';

class Homepage extends StatefulWidget{
  _Homepage createState() => _Homepage();
}

class _Homepage extends State<Homepage>{
  // Index variable for the tabs.
  int _selectedIndex = 0;
  // Bag count
  static int _bags = 0;

  // Large font style.
  static const TextStyle largeStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
  );

  // Initial state. Get the user and details.
  @override
  void initState()
  {
    super.initState();
    // Get profile info to display it on the profile page.
    setState(() {
      Future<UserInfo> FutureProfileInfo = getUser();
    });
  }

  Future<UserInfo> getUser() async {
    final http.Response _response = await http.get(
      'http://localhost3000.us-east-2.elasticbeanstalk.com/api/users/getUserAndDetail',
      headers: headers,
    );

    if (_response.statusCode == 200) {
      var parsedJson = json.decode(_response.body);
      SessionFirstName = parsedJson['firstname'];
      SessionLastName = parsedJson['lastname'];
      SessionEmail = parsedJson['email'];
      SessionAge = parsedJson['detials']['age'];
      SessionHeight = parsedJson['detials']['height'];
      SessionWeight = parsedJson['detials']['weight'];

      return UserInfo.fromJson(json.decode(_response.body));
    }
    else {
      print(_response.statusCode);
      print(_response.body);
    }
  }

  static Text bagCount()
  {
    if (_bags == 0)
      return Text("[No bags]");
    else
      return Text("[$_bags bags]");
  }

  // These three are each of the tabs.
  List<Widget> _widgetOptions = <Widget>[
    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("Welcome to Sporta", style: largeStyle)
        ]
    ),
    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("Personal", style: largeStyle),
          Text("Golf Bags", style: largeStyle),
          bagCount(),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: (){
                  _bags++;
                  print("Added bag!");
                },
                child: Text("Add bag")
              )
            ],
          )
        ]
    ),
    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Text("Events", style: largeStyle),
        ]
    )
  ];

  // SetState for changing the tab index.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Displays the floating action button if we're on the events page.
  FloatingActionButton isIndex2() {
    // If the current index is 2 (events page) return the button.
    if (_selectedIndex == 2)
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(
              builder: (context) => CreateEvent()
          )
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
      );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          drawer: Drawer(
                child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                        ),
                        child: Text('Options',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text('Profile'),
                          onTap: (){
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) => Profile()));
                          }
                          ),
                      ListTile(
                        leading: Icon(Icons.arrow_back),
                        title: Text('Logout'),
                        onTap: () {
                          Navigator.pop(context);
                          },
                      )
                    ]
                )
            ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),

          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Overview'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Personal'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                title: Text('Events'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.deepOrange,
            onTap: _onItemTapped,
          ),
          floatingActionButton: isIndex2(),
      )
    );
  }
}
