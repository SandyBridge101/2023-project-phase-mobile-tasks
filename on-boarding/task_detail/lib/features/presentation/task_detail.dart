import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime deadline=DateTime(2024,04,09);
String formatted_deadline=DateFormat.yMMMMd('en_US').format(deadline);

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
            color: Colors.white,
            alignment: Alignment.center,
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                  child: Image(
                    width: 200,
                    height: 200,
                    image:AssetImage('lib/assets/tm2.jpg'),
                  ),
                ),

                Container(
                  child: Column(
                    children: <Widget>[
                      _detail_card('UI/UX Design','Title',300,50),
                      _detail_card(formatted_deadline,'Deadline',300,50),
                      _detail_card('First i have to animate my logo and prototype the design it is very important','Description',300,200)
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
            elevation:3,
            child: Container(
              color: Colors.white70,
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