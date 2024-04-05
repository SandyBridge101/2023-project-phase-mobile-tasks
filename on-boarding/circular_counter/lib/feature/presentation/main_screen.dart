
import 'package:circular_counter/feature/domain/logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:circular_counter/feature/domain/logic.dart";

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            'Circular Counter',
            style:TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
        body:Center(
          child: Container(
            alignment:Alignment.center,
            child: CounterUI(),
          ),
        ),
      ),

    );
  }
}

class CounterUI extends StatefulWidget{
  const CounterUI({super.key});

  @override
  State<CounterUI> createState()=>_CounterUIState();
}

class _CounterUIState extends State<CounterUI>{
  int _countervalue=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Counter Value',
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color:Colors.black,

            ),
          ),
          Text('$_countervalue',
              style:const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color:Colors.amber,
              )
          ),
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                  child:ElevatedButton(
                      onPressed: (){
                        setState(() {
                          _countervalue=Logic().increment(_countervalue);
                        });
                      },
                      child:const Text(
                        'Increase',
                        style:TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  )
              ),
              Container(
                margin:EdgeInsets.all(10),
                  child:ElevatedButton(
                      onPressed: (){
                        setState(() {
                          _countervalue=Logic().decrement(_countervalue);
                        });
                      },
                      child: const Text('Decrease',
                        style:TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      )
                  )
              )

            ],
          )
        ],

      ),
    );
  }
}