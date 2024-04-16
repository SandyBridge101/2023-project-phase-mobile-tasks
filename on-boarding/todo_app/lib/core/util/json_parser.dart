import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/features/todo/data/models/todo_model.dart';
import 'package:dartz/dartz.dart';


Future <List> readJson() async{
  String directory = (await getApplicationDocumentsDirectory()).path;
  List<dynamic> res;
  print('reading........');

  try{
    var input= await File('$directory/tasks.json').readAsString();
    final tasks=jsonDecode(input);
    res=tasks;
  }
  catch(e){
    print(e);
    res=[];
  }

  //File('$directory/tasks.json').writeAsStringSync(jsonEncode(tasks));
  return res;
}

Future<void> writeJson(String title, String description, String due_date,String status) async {
  final Map<String,dynamic> data= new Map<String,dynamic>();
  String directory = (await getApplicationDocumentsDirectory()).path;
  data["title"]=title;
  data["description"]=description;
  data["due_date"]=due_date;
  data["status"]=status;
  tasks= await readJson();
  tasks.add(data);
  print(tasks);



  await File('$directory/tasks.json').writeAsString(jsonEncode(tasks));
  var n= await File('$directory/tasks.json').readAsString();
  print(n);
}

Future<void> updateJson(int index,String title, String description, String due_date,String status,List tasks) async {

  String directory = (await getApplicationDocumentsDirectory()).path;
  final Map<String,dynamic> data= new Map<String,dynamic>();
  data["title"]=title;
  data["description"]=description;
  data["due_date"]=due_date;
  data["status"]=status;
  tasks.add(data);
  print(tasks);


  await File('$directory/tasks.json').writeAsString(jsonEncode(tasks));
  var n= await File('$directory/tasks.json').readAsString();
  print(n);
}

Future<void> refreshJson() async {
  final Map<String,dynamic> data= new Map<String,dynamic>();
  String directory = (await getApplicationDocumentsDirectory()).path;
  print(tasks);

  await File('$directory/tasks.json').writeAsString(jsonEncode(tasks));
  var n= await File('$directory/tasks.json').readAsString();
  print(n);
}
