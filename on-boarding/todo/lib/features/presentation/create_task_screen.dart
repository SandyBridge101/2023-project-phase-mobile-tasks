
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends StatefulWidget{
  const CreateTaskScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: '1',
                child: Text('Profile'),
              ),
              PopupMenuItem(
                value: '2',
                child: Text('Setting'),
              ),
              PopupMenuItem(
                value: '3',
                child: Text('Logout'),
              ),
            ],
          )
        ],

        leading: IconButton(
          icon:Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(238, 111, 87, 1),
          ),
          onPressed: (){},
        ),

        title: Container(
          child: Text('Create new task',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          alignment:Alignment.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    _input_card('Enter Task name','Mobile Task Name'),
                    _input_date_card('Task due date','Due Date'),
                    _input_card('Enter task description','Description')
                  ],
                ),
              ),

              Container(
                child: ElevatedButton(
                  child: Text('Add Task'),
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromRGBO(238, 111, 87, 1),
                    elevation: 5,
                  ),

                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

Widget _input_card(String hint,String title){
  return Container(
    margin: EdgeInsets.all(20),
    child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
              title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(238, 111, 87, 1),
            ),
          ),
        ),
        Container(

          child: Card(
            //TODO:Make width dynamic
            shadowColor: Colors.black,
            elevation:10 ,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            child: Container(
              color: Colors.white,
              width: 500,
              child: TextField(
                decoration: InputDecoration(
                    hintText: hint
                ),
              ),
            ),

          ),
        )
      ],
    ),
  );
}

Widget _input_date_card(String hint,String title){
  return Container(
    margin: EdgeInsets.all(20),
    child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(238, 111, 87, 1),
            ),
          ),
        ),
        Container(

          child: Card(
            //TODO:Make width dynamic
            shadowColor: Colors.black,
            elevation:10 ,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin:EdgeInsets.all(10),
                  child: Text(
                      DateFormat.yMMMd('en_US').format(DateTime.now()),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,

                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.calendar_month),
                    onPressed: (){},
                    color: Color.fromRGBO(238, 111, 87, 1),
                  ),
                )
              ],
            ),
            ),

          ),

      ],
    ),
  );
}
