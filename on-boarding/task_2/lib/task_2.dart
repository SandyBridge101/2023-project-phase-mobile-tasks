import 'dart:io';

class Task {
  String _title = "";
  String _description = "";
  String _date = "";
  bool _status = false;

  Task(String title, String description, String date, bool status) {
    this._title = title;
    this._description = description;
    this._date = date;
    this._status = status;
  }

  void display() {
    print('Title:   ' + this._title);
    print('Description:   ' + this._description);
    print('Due date:   ' + this._date);
    //print('Status:   '+this.status);
  }

  void setTitle(String title) {
    this._title = title;
  }

  void setDescription(String description) {
    this._description = description;
  }

  void setDate(String due_date) {
    this._date = due_date;
  }

  void setStatus(bool status) {
    this._status = status;
  }

  String getTitle() {
    return this._title;
  }

  String getDescription() {
    return this._description;
  }

  String getDate() {
    return this._date;
  }

  bool getStatus() {
    return this._status;
  }
}

class TaskManager {
  List _tasks = <Task>[];

  List getTasks() {
    return this._tasks;
  }

  void addTask(String title, String description, String date, bool status) {
    Task newTask = Task(title, description, date, status);
    _tasks.add(newTask);
  }

  void editTaskTitle(int taskId, String value) {
    this._tasks[taskId].setTitle(value);
  }

  void editTaskDescription(int taskId, String value) {
    this._tasks[taskId].setDescription(value);
  }

  void editTaskDate(int taskId, String value) {
    this._tasks[taskId].setDate(value);
  }

  void editTaskStatus(int taskId, bool value) {
    this._tasks[taskId].setStatus(value);
  }

  void viewPending() {
    for (Task task in _tasks) {
      if (task.getStatus() == false) {
        print('Title:   ' + task.getTitle());
        print('Description:   ' + task.getDescription());
        print('Due date:   ' + task.getDate());
      }
    }
  }

  void viewComplete() {
    for (Task task in _tasks) {
      if (task.getStatus() == true) {
        print('Title:   ' + task.getTitle());
        print('Description:   ' + task.getDescription());
        print('Due date:   ' + task.getDate());
      }
    }
  }

  void viewAll() {
    for (Task task in _tasks) {
      print('Title:   ' + task.getTitle());
      print('Description:   ' + task.getDescription());
      print('Due date:   ' + task.getDate());
    }
  }

  void deleteTask(int taskId) {
    _tasks.removeAt(taskId);
  }
}

//####################################################################################################################################

void main() {
  TaskManager manager = TaskManager();

  while (true) {
    int state = runTaskManager(manager);
    if (state == 1) {
      break;
    }
  }
}

int runTaskManager(TaskManager manager) {
  print(
      '\n\nChoose an option from 1-6\n1.Add Task \n2.Edit Task Title \n3. Edit Task Description \n4. Edit Task Date \n5. Set Task as completed \n6. Set Task as pending \n7.View all Tasks \n8.View pending Tasks \n9.View completed Tasks \n10.Delete Task\n11.Exit\n');
  String? input = stdin.readLineSync();
  int? op = int.tryParse(input!);

  switch (op) {
    case 1:
      print('Input Title: \n');
      String? title = stdin.readLineSync();
      print('Input  Description: \n');
      String? description = stdin.readLineSync();
      print('Input Date (DD/MM/YYYY): \n');
      String? date = stdin.readLineSync();

      if (title == null || description == null || date == null) {
        print('Input error!');
      } else {
        manager.addTask(title, description, date, false);
      }
      break;
    case 2:
      print('What Task do you want to edit: \n');
      int x = 0;
      for (Task task in manager.getTasks()) {
        print(x.toString() + ' ' + task.getTitle());
        x = x + 1;
      }
      String? input = stdin.readLineSync();
      int? option = int.tryParse(input!);
      if (option! >= manager.getTasks().length) {
        print('Task Id is invalid');
        break;
      }
      print('Enter your desired Title: \n');
      String? value = stdin.readLineSync();

      if (option == null || value == null) {
        print('input error!');
      } else {
        manager.editTaskTitle(option, value);
      }
      break;
    case 3:
      print('What Task do you want to edit: \n');
      int x = 0;
      for (Task task in manager.getTasks()) {
        print(x.toString() + ' ' + task.getTitle());
        x = x + 1;
      }

      String? input = stdin.readLineSync();
      int? option = int.tryParse(input!);

      if (option! >= manager.getTasks().length) {
        print('Task Id is invalid');
        break;
      }

      print('Enter your desired Description: \n');
      String? value = stdin.readLineSync();

      if (option == null || value == null) {
        print('input error!');
      } else {
        manager.editTaskDescription(option, value);
      }
      break;
    case 4:
      print('What Task do you want to edit: \n');
      int x = 0;
      for (Task task in manager.getTasks()) {
        print(x.toString() + ' ' + task.getTitle());
        x = x + 1;
      }
      String? input = stdin.readLineSync();
      int? option = int.tryParse(input!);

      if (option! >= manager.getTasks().length) {
        print('Task Id is invalid');
        break;
      }

      print('Enter your desired Date (DD/MM/YYYY): \n');
      String? value = stdin.readLineSync();

      if (option == null || value == null) {
        print('input error!');
      } else {
        manager.editTaskDate(option, value);
      }
      break;
    case 5:
      print('What Task do you want to edit: \n');
      int x = 0;
      for (Task task in manager.getTasks()) {
        print(x.toString() + ' ' + task.getTitle());
        x = x + 1;
      }
      String? input = stdin.readLineSync();
      int? option = int.tryParse(input!);

      if (option! >= manager.getTasks().length) {
        print('Task Id is invalid');
        break;
      }

      if (option == null) {
        print('input error!');
      } else {
        manager.editTaskStatus(option, true);
      }

      break;
    case 6:
      print('What Task do you want to edit: \n');
      int x = 0;
      for (Task task in manager.getTasks()) {
        print(x.toString() + ' ' + task.getTitle());
        x = x + 1;
      }
      String? input = stdin.readLineSync();
      int? option = int.tryParse(input!);

      if (option! >= manager.getTasks().length) {
        print('Task Id is invalid');
        break;
      }

      if (option == null) {
        print('input error!');
      } else {
        manager.editTaskStatus(option, false);
      }
      break;
    case 7:
      manager.viewAll();
      break;
    case 8:
      manager.viewPending();
      break;
    case 9:
      manager.viewComplete();
      break;
    case 10:
      print('What Task do you want to delete: \n');
      int x = 0;
      for (Task task in manager.getTasks()) {
        print(x.toString() + ' ' + task.getTitle());
        x = x + 1;
      }
      String? input = stdin.readLineSync();
      int? option = int.tryParse(input!);

      if (option! >= manager.getTasks().length) {
        print('Task Id is invalid');
        break;
      }

      if (option == null) {
        print('input error!');
      } else {
        manager.deleteTask(option);
      }

      break;
    case 11:
      return 1;
      break;
  }
  return 0;
}
