import 'package:flutter/material.dart';

class TaskDetailScreen extends StatefulWidget{
  const TaskDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text('Task Detail'),
        ),
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
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                child: Image(
                  width: 200,
                  height: 200,
                  image:AssetImage('lib/assets/tm2.png'),
                ),
              ),

              Container(
                child: Column(
                  children: <Widget>[
                    _detail_card('UI/UX Design','Title',200,50),
                    _detail_card('02/04/2024','Deadline',200,50),
                    _detail_card('First i have to animate my logo and prototype the design it is very important','Description',200,200)
                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }
}

Widget _detail_card(String content,String title,double x, double y){
  return Container(
    child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: Text(title),
        ),
        Container(
          width: x,
          height: y,
          child: Card(
            child: Container(
              child: Text(
                content
              ),
            ),
          ),
        )
      ],
    ),
  );
}