import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/todo/data/models/todo_model.dart';


void main(){
  test('TodoModel data class test toJson', (){
    var todo_instance=TodoModel('Design UI/UX', 'Finish the UI', 'April 24, 2024', 'pending');
    var result=todo_instance.toJson();
    var answer={
      'title':'Design UI/UX',
      'description':'Finish the UI',
      'due_date':'April 24, 2024',
      'status':'pending'
    };

    expect(result, answer);

  });

  test('TodoModel data class test fromJson', (){
    
    var param={
      'title':'Design UI/UX',
      'description':'Finish the UI',
      'due_date':'April 24, 2024',
      'status':'pending'
    };

    var todo_instance=TodoModel.fromJson(param);

    var result=todo_instance.title;

    expect(result, 'Design UI/UX');

  });
}