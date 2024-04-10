import 'package:flutter/material.dart';
import 'package:todo_app/features/presentation/create_task_screen.dart';
import 'package:todo_app/features/presentation/main_screen.dart';
import 'package:todo_app/features/presentation/todo_list.dart';
import 'package:todo_app/features/data/data_parser.dart';



Future tasks() async {
  List tasks= await readJson();
  return tasks;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Task',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),

        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/':(context)=>MainScreen(),
        '/todo':(context)=>TodoListScreen(),
        '/create_task':(context)=>CreateTaskScreen()
      },
    );
  }
}
