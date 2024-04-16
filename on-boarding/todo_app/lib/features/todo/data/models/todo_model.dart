

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

