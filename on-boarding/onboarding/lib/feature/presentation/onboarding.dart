import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 111, 87, 1),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Image(
                  width: 700,
                  height: 700,
                  image:AssetImage('lib/assets/tm1.png'),
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text('Get Started',
                      style:TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      )
                  ),
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