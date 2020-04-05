import 'package:flutter/material.dart';
import 'Settings.dart';
import 'Profile.dart';

class Homepage extends StatelessWidget{
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: Text(
                'Options',
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
                // Close the drawer
                Navigator.pop(context);
                // Logout
                Navigator.pop(context);
              },
            )
          ]
        )
      )
    );
  }
}
