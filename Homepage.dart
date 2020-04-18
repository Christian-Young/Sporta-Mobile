import 'package:flutter/material.dart';
import 'Profile.dart';
import 'CreateEvent.dart';
import 'ShowDialog.dart';
import 'package:http/http.dart' as http;
import 'models/UserInfo.dart';
import 'models/BagInfo.dart';
import 'models/ClubInfo.dart';
import 'models/GetBags.dart';
import 'Session.dart';
import 'dart:convert';
import 'dart:async';

class Homepage extends StatefulWidget{
  _Homepage createState() => _Homepage();
}

/*
class _GolfBagDialogState extends State<GolfBagDialog>{
  // Controllers
  final _bagNameController = TextEditingController();
  final _clubNameController = TextEditingController();
  final _clubTypeController = TextEditingController();
  // Index variable for the tabs.
  int _selectedIndex = 0;
  // Bag count
  int _bags = 0;
  // Number of clubs
  int _numClubs = 0;
  // Dropdownvalue for number of bags
  String _dropdownValue = 'Wood';

  Widget build(BuildContext context){
    showDialog(
      context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
            'Bag', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                    controller: _bagNameController,
                    decoration: InputDecoration(hintText: "Bag Name")
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                  child: Text(
                      "Club", style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                TextField(
                    controller: _clubNameController,
                    decoration: InputDecoration(hintText: "Club Name")
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text("Club type"),
                ),
                DropdownButton<String>(
                  value: _dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepOrange),
                  onChanged: (String newValue) {
                    setState(() {
                      _dropdownValue = newValue;
                    });
                  },
                  items: <String>['Wood', 'Iron', 'Wedge', 'Putter'].map<
                      DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 18)),
                    );
                  }).toList(),
                ),
                RaisedButton(
                  child: Text("Add club"),
                  onPressed: () {
                    if (_clubNameController.text == "")
                      DialogPopUp(context, "Name your club.");
                    setState(() {
                      _numClubs++;
                    });
                  },
                ),
                Text("$_numClubs clubs will be in this bag",
                    style: TextStyle(fontSize: 18))
              ],
            )
        ),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Add bag'),
              onPressed: () {
                if (_bagNameController.text == "")
                  DialogPopUp(context, "Name your bag.");
                else {
                  Navigator.of(context).pop();
                }
              }
          ),
          new FlatButton(
              child: new Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                _bagNameController.text = "";
                _clubNameController.text = "";
                _numClubs = 0;
              }
          )
        ],
      );
    });
  }
}

class GolfBagDialog extends StatefulWidget{
  @override
  _GolfBagDialogState createState() => new _GolfBagDialogState();
}
*/

class _Homepage extends State<Homepage>{
  // Controllers
  final _bagNameController = TextEditingController();
  final _clubNameController = TextEditingController();
  // Index variable for the tabs.
  int _selectedIndex = 0;
  // Bag count
  int _bags = 0;
  // Number of clubs
  int _numClubs = 0;
  // Drop down value for number of bags
  String _clubType = 'Wood';
  // POST Bag model
  Future<BagInfo> futureBagInfo;
  // Club model
  Future<ClubInfo> futureClubInfo;
  // Get all bags model
  Future<GetBags> futureGetBags;
  // User model
  Future<UserInfo> futureProfileInfo;
  final String NO_CLUB = "0";
  final String WOOD = "1";
  final String IRON = "2";
  final String WEDGE = "3";
  final String PUTTER = "4";
  String bagID;
  List<Widget> BagList = new List<Widget>();

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
    futureProfileInfo = getUser();
    futureGetBags = getBags();
  }

  Future<UserInfo> getUser() async {
    final http.Response _response = await http.get(
      'http://localhost3000.us-east-2.elasticbeanstalk.com/api/users/getUserAndDetail',
      headers: headers,
    );

    if (_response.statusCode == 200) {
      var parsedJson = json.decode(_response.body);
      setState(() {
        SessionFirstName = parsedJson['firstname'];
        SessionLastName = parsedJson['lastname'];
        SessionEmail = parsedJson['email'];
        SessionAge = parsedJson['details']['age'];
        SessionHeight = parsedJson['details']['height'];
        SessionWeight = parsedJson['details']['weight'];
      });

      return UserInfo.fromJson(json.decode(_response.body));
    }
    else {
      print(_response.statusCode);
      print(_response.body);
    }
  }
  Future<GetBags> getBags() async {
    final http.Response _response = await http.get(
      'http://localhost3000.us-east-2.elasticbeanstalk.com/api/golf/getAllGolfBags',
      headers: headers,
    );

    if (_response.statusCode == 200) {

      return GetBags.fromJson(json.decode(_response.body));
    }
    else {
      print(_response.statusCode);
      print(_response.body);
    }
  }
  Future<BagInfo> postBag(dynamic info) async {
    final http.Response _response = await http.post(
        'http://localhost3000.us-east-2.elasticbeanstalk.com/api/golf/createGolfBag',
        headers: headers,
        body: info
    );

    // If successful login, navigate to homepage.
    if (_response.statusCode == 200) {
      return BagInfo.fromJson(json.decode(_response.body));
    }
    // If it's some other error that the user doesn't need to know about.
    else {
      print(_response.statusCode);
      print(_response.body);
    }
  }
  Future<ClubInfo> postClub(dynamic info) async {
    final http.Response _response = await http.post(
        'http://localhost3000.us-east-2.elasticbeanstalk.com/api/golf/createGolfclub',
        headers: headers,
        body: info
    );

    // If successful login, navigate to homepage.
    if (_response.statusCode == 200) {
      return ClubInfo.fromJson(json.decode(_response.body));
    }
    // If it's some other error that the user doesn't need to know about.
    else {
      print(_response.statusCode);
      print(_response.body);
    }
  }

  Text bagCount() {
    if (_bags == 0)
      return Text("[No bags]");
    else
      return Text("[$_bags bags]");
  }

  // SetState for changing the tab index.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> displayBags(){
    BagList = new List<Widget>();

    BagList.add(Text("Golf Bags", style: largeStyle));

    if(_bags == 0) {
        BagList.add(Text("No bags to show"));
        BagList.add(bagCount());
        BagList.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                onPressed: (){
                  _simp();
                },
                child: Text("Add bag")
            )
          ],
        ));
        return BagList;
    }
    else {
      BagList.add(bagCount());
      BagList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
              onPressed: (){
                _simp();
              },
              child: Text("Add bag")
          )
        ],
      ));
      return BagList;
    }
  }

  String determineClubType() {
    if(_numClubs == 0)
      return NO_CLUB;

    switch(_clubType)
    {
      case "Wood":
        return WOOD;

      case "Iron":
        return IRON;

      case "Wedge":
        return WEDGE;

      case "Putter":
        return PUTTER;
    }
  }

  Widget select(){

    switch (_selectedIndex)
    {
      case 0: return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Welcome to Sporta", style: largeStyle)
          ]
      );
      break;

      case 1: return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: displayBags()
      );
      break;

      case 2: return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            Text("Events", style: largeStyle),
          ]
      );
    }
  }

  _simp() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Bag', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      controller: _bagNameController,
                      decoration: InputDecoration(hintText: "Bag Name")
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Text(
                        "Club", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  TextField(
                      controller: _clubNameController,
                      decoration: InputDecoration(hintText: "Club Name")
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text("Club type"),
                  ),
                  DropdownButton<String>(
                    value: _clubType,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color:Colors.deepOrange),
                    onChanged: (String newValue) {
                      setState(() {
                        _clubType = newValue;
                      });
                      },
                    items: <String> ['Wood', 'Iron', 'Wedge', 'Putter'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(fontSize: 18)),
                      );
                    }).toList(),
                  ),
                  RaisedButton(
                    child: Text("Add club"),
                    onPressed: (){
                      if (_clubNameController.text == "")
                        DialogPopUp(context, "Name your club.");
                      setState(() {
                        _numClubs++;
                      });
                    },
                  ),
                  Text(_numClubs == 1 ? "$_numClubs club will be in this bag"
                      : "$_numClubs clubs will be in this bag", style: TextStyle(fontSize: 18))
                ],
              )
            ),
            actions: <Widget>[
              new FlatButton(
                  child: new Text('Add bag'),
                  onPressed: () {
                    if (_bagNameController.text == "")
                      DialogPopUp(context, "Name your bag.");
                    else {
                      futureBagInfo = postBag(jsonEncode(
                          <String, String>{'bagName': _bagNameController.text}));
                      futureGetBags = getBags();
                      /*futureClubInfo = postClub(
                          jsonEncode(<String, String>{
                            'golfBag': bagID,
                            'clubName': _clubNameController.text,
                            'clubType': determineClubType(),
                          })
                      );*/
                      _bags++;
                      Navigator.of(context).pop();
                    }
                  }
              ),
              new FlatButton(
                child: new Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _bagNameController.text = "";
                  _clubNameController.text = "";
                  _numClubs = 0;
                }
              )
            ],
          );
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
            child: select(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
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
      ),
    );
  }
}
