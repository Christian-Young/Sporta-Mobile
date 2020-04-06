import 'package:flutter/material.dart';
import 'Settings.dart';
import 'Profile.dart';

class Homepage extends StatelessWidget{

  void welcome(BuildContext context){
    final snackBar = SnackBar(content: Text("Welcome [name here]!"));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Home'),
              bottom: TabBar(
                  tabs: [
                    // Overview
                    Tab(icon: Icon(Icons.library_books)),
                    // Sports
                    Tab(icon: Icon(Icons.directions_run)),
                    // More sports
                    Tab(icon: Icon(Icons.access_alarm))
                  ]
              ),
            ),
            body: TabBarView(
                children: [
                Text("Overview"),
                Text("Sports"),
                Text("More sports")
              ]
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
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) => Settings()));
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
          )
      )
    );
  }
}
