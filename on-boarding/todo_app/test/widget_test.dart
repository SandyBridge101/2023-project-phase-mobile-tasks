// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/presentation/create_task_screen.dart';
import 'package:todo_app/features/presentation/main_screen.dart';
import 'package:todo_app/features/presentation/task_detail.dart';
import 'package:todo_app/features/presentation/todo_list.dart';
import 'package:todo_app/features/domain/logic.dart';

import 'package:todo_app/main.dart';

void main() {
  testWidgets('Main Screen to Todo List Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());



    // Verify that our counter starts at 0.
    final main_image=find.byKey(ValueKey('main screen image'));
    final main_button=find.byKey(ValueKey('main screen button'));

    //expect return
    expect(main_button, findsOneWidget);

    //execute
    await tester.tap(main_button);
    for (int i = 0; i < 5; i++) {
      await tester.pump(Duration(seconds: 1));
    }

    expect(find.text('Todo List'), findsOneWidget);

  });

  testWidgets('Create Task Test', (WidgetTester tester) async {
    // Bui ld our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: CreateTaskScreen(),));

    // Verify that our counter starts at 0.
    final header=find.byKey(ValueKey('create task header'));
    final title=find.byKey(ValueKey('title field'));
    final description=find.byKey(ValueKey('description field'));
    final date=find.byKey(ValueKey('date picker'));
    final button=find.byKey(ValueKey('create task button'));

    //expect return
    expect(button, findsOneWidget);
    expect(title, findsWidgets);
    expect(description, findsWidgets);
    expect(date, findsWidgets);
    expect(header, findsOneWidget);


    //execute
    await tester.enterText(title, 'New Title');
    await tester.enterText(description, 'New Description');
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('New Title'), findsOneWidget);


  });

  testWidgets('CreateTask Screen Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: CreateTaskScreen(),));

    // Verify that our counter starts at 0.
    final header=find.byKey(ValueKey('create task header'));
    final field=find.byKey(ValueKey('create task field'));
    final button=find.byKey(ValueKey('create task button'));


    //execute
    await tester.tap(button);
    await tester.pump();

    //expect return
    expect(button, findsOneWidget);
    expect(field, findsWidgets);
    expect(header, findsOneWidget);
  });

  testWidgets('ToDo Screen Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
        MaterialApp(
          home: TodoListScreen(),
          initialRoute: '/todo',
          routes: {
            '/todo':(context)=>TodoListScreen(),
            '/create_task':(context)=>CreateTaskScreen()
          },
    ));
    

    // Verify that our counter starts at 0.
    final icon=find.byKey(ValueKey('todo icon'));


    expect(find.byType(GestureDetector), findsWidgets);
    expect(icon, findsWidgets);
  });



}
