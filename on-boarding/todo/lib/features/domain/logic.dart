import 'package:add_task/features/data/data_parser.dart';

class TaskManager {

  void addTask(String title, String description, String date, bool status) {
    writeJson(title, description, date);
  }


  Future<List> getTasks() async{

    return await readJson();
  }

}


