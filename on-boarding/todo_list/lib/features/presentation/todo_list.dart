import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
double primary_font_size=13;
double secondary_font_size=2;

DateTime deadline=DateTime(2024,04,09);
String formatted_deadline=DateFormat.yMMMMd('en_US').format(deadline);

class TodoListScreen extends StatefulWidget{
  const TodoListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child:Text('Todo List'),
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
        child:Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image(
                        width: 200,
                        height: 200,
                        image:AssetImage('lib/assets/tm1.png'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tasks List',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    _task_card('Watch Kenny Liu',formatted_deadline,'lib/assets/alph_w.png',Color.fromRGBO(225, 96, 96, 1)),
                    _task_card('Enter Bahrain',formatted_deadline,'lib/assets/alph_e.png',Color.fromRGBO(132, 231, 130, 1)),
                    _task_card('Enjoy Dagonussy',formatted_deadline,'lib/assets/alph_e.png',Color.fromRGBO(251, 200, 83, 1)),
                    _task_card('Accept admission letter',formatted_deadline,'lib/assets/alph_a.png',Color.fromRGBO(225, 96, 96, 1)),
                    _task_card('UI/UX design',formatted_deadline,'lib/assets/alph_u.png',Color.fromRGBO(132, 231, 130, 1))
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor:Colors.white ,
                      backgroundColor:Color.fromRGBO(238, 111, 87, 1),
                      shape: BeveledRectangleBorder(
                        borderRadius:BorderRadius.circular(5),
                      )

                  ),
                  child: Text('Create Task'),
                  onPressed: (){},

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _task_card(String title,String date,String icon_path,Color status){
  return Container(
    margin: EdgeInsets.all(10),
    child: Card(

      elevation: 10,
      color: Colors.white,
      child: IntrinsicHeight(
        child: Row(
          children:<Widget> [
            Expanded(
                child:Container(
                  width: 30,
                  height: 30,
                  child: Image(
                    image: AssetImage(icon_path),
                  ),
                )
            ),

            Expanded(
              child:Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: primary_font_size,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
                child:Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.topRight,
                      child: Text(
                        date,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Container(
                      child:VerticalDivider(
                        indent: 10,
                        thickness: 4,
                        width: 2,
                        color: status,
                        endIndent: 10,
                      ),
                    ),
                  ],
                ),
            ),

          ],
        ),
      ),
    ),
  );
}

