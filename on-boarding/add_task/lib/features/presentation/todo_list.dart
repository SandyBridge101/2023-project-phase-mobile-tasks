import 'package:flutter/material.dart';

double primary_font_size=16;
double secondary_font_size=5;
const Color primary_color=Color(0xee6f57);

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
                        image:AssetImage('lib/assets/tm1.jpg'),
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
                    _task_card('Watch Kenny Liu','02/04/2024','lib/assets/alph_w.png',Colors.red),
                    _task_card('Enter Bahrain','01/08/2026','lib/assets/alph_e.png',Colors.green),
                    _task_card('Enjoy Dagonussy','05/05/2024','lib/assets/alph_e.png',Colors.yellow),
                    _task_card('Accept admission letter','05/05/2024','lib/assets/alph_a.png',Colors.red),
                    _task_card('UI/UX design','05/05/2024','lib/assets/alph_u.png',Colors.green)
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
                      borderRadius:BorderRadius.circular(0.2),
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
                  width: 50,
                  height: 50,
                  child: Image(
                    image: AssetImage(icon_path),
                  ),
                )
            ),

            Expanded(
              child:Container(
                padding: EdgeInsets.all(5),
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
                child:Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.topRight,
                  child: Text(
                      date
                  ),
                )
            ),
            Expanded(
                child:Container(
                  child:VerticalDivider(
                    indent: 10,
                    thickness: 5,
                    width: 5,
                    color: status,
                    endIndent: 10,
                  ),
                ),
            ),
          ],
        ),
      ),
    ),
  );
}

