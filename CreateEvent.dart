import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget{
  _CreateEvent createState() => _CreateEvent();
}

class _CreateEvent extends State<CreateEvent>{
  final _titleController = TextEditingController();
  final _courseController = TextEditingController();
  final _holeController = TextEditingController();
  List<TextEditingController> _parsController;
  List<Widget> widgetlist;

  void createHoles(int holeCount){
    _parsController = new List<TextEditingController>(holeCount);
    widgetlist = new List<Widget>();

    for (int i = 0; i < holeCount; i++)
    {
      setState(() {
        widgetlist.add(Expanded(
          child: Container(
            width: 70.0,
            child: TextField(
                style: TextStyle(
                    fontSize: 17
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: (i+1).toString(),
                )
            ),
          )
        )
        );
      });
    }
  }

  Text areParsDisplayed(){
    if(_holeController.text != '')
    {
      if (int.parse(_holeController.text) > 0)
        return new Text("Pars:");
      else
        return new Text("");
    }
    else
      return new Text("");
  }

  Row parsForEachHole(){
    if (_holeController.text == '')
      return new Row();

    if (widgetlist != null)
    {
        return new Row(children: widgetlist);
    }
    else
      return new Row();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    )
                )
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                    controller: _courseController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Course',
                    )
                )
            ),
            Container(
              width: 70.0,
              child: TextField(
                style: TextStyle(
                  fontSize: 17
                ),
                textAlign: TextAlign.center,
                  controller: _holeController,
                  onSubmitted: (_holeController) {
                    setState(() {
                      createHoles(int.parse(_holeController));
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Holes',
                  )
              ),
            ),
            areParsDisplayed(),
            parsForEachHole(),
            RaisedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('Create Event')
            ),
          ],
        ),
      ),
    );
  }
}
