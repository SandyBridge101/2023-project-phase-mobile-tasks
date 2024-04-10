
import 'dart:convert';
import 'dart:io';

List tasks=[];

Future <List> readJson() async{
  var input= await File('./tasks.json').readAsString();
  final tasks=jsonDecode(input);
  List<dynamic> res=tasks;
  return res;
}

Future<void> writeJson(String title, String description, String due_date) async {
  final Map<String,dynamic> data= new Map<String,dynamic>();
  data["title"]=title;
  data["description"]=description;
  data["due_date"]=due_date;
  tasks= await readJson();
  tasks.add(data);
  print(tasks);

  File('./tasks.json').writeAsStringSync(jsonEncode(tasks));
}

Future<void> main()async {
  tasks= await readJson();

  writeJson('Learn Flutter', 'Implement UI', '12/04/2024');

}