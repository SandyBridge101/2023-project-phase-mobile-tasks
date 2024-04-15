import 'package:intl/intl.dart';

class Task{
  int? id;
  String? title;
  String? description;
  DateTime? due_date;
  String? status;

  Task(int id,String title,String description,DateTime due_date, String status){
    this.id=id;
    this.title=title;
    this.description=description;
    this.due_date=due_date;
    this.status=status;
  }

  String convertDateToString(){
    return DateFormat.yMMMd().format(this.due_date!);
  }
}