import 'package:flutter/material.dart';
import 'Settings.dart';
import 'Profile.dart';
import 'CreateEvent.dart';

class Homepage extends StatefulWidget{
  _Homepage createState() => _Homepage();
}

class _Homepage extends State<Homepage>{
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
  );

  static List<Widget> _widgetOptions = <Widget>[
    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("Welcome [name here] !", style: optionStyle)
        ]
    ),
    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("Personal", style: optionStyle),
        ]
    ),
    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Text("Events", style: optionStyle),
        ]
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /*
  void welcome(){
    final snackBar = SnackBar(content: Text("Welcome [name here]!"));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
   */

  // Displays the floating action button if we're on the events page.
  FloatingActionButton isIndex2() {
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
