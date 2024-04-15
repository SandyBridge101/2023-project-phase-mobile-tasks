import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dartz/dartz.dart';



List tasks=[];

class TodoModel{
  final String title;
  final String description;
  final String due_date;
  final String status;

  TodoModel(this.title, this.description, this.due_date, this.status);

  Map<String,dynamic> toJson() =>{
    'title':title,
    'description':description,
    'due_date':due_date,
    'status':status
  };

  TodoModel.fromJson(Map<String,dynamic> json):
      title=json['title'] as String,
      description=json['description'] as String,
      due_date=json['due_date'] as String,
      status=json['status'] as String
  ;
}

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

Future<void> refreshJson(int index,String title, String description, String due_date,String status,List tasks) async {
  final Map<String,dynamic> data= new Map<String,dynamic>();
  String directory = (await getApplicationDocumentsDirectory()).path;
  print(tasks);

  await File('$directory/tasks.json').writeAsString(jsonEncode(tasks));
  var n= await File('$directory/tasks.json').readAsString();
  print(n);
}
