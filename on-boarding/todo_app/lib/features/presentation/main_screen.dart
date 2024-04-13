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
                  key: Key('main screen image'),
                  width: 500,
                  height: 500,
                  image:AssetImage('lib/assets/tm1.png'),
                ),
              ),
              Container(
                child: ElevatedButton(
                  key: Key('main screen button'),
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
                  onPressed: (){
                    Navigator.pushNamed(context,'/todo');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}