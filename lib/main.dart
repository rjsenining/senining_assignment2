import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: TodoList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<dynamic> _todoItems = [];


  Future<void> fetchTodoItems() async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    var response = await http.get(uri);
    var todoItems = jsonDecode(response.body);
    setState(() {
      _todoItems = todoItems;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTodoItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: _todoItems.length,
        itemBuilder: (context, index) {
          var todoItem = _todoItems[index];
          return ListTile(
            title: Text(todoItem['title']),
            trailing: Checkbox(
                value: todoItem['completed'],
                onChanged: (bool? newValue) {
                  if(newValue!=null){
                    setState(() {
                      _todoItems[index]['completed'] = newValue;
                    });
                  }
                }),
          );
        },
      ),
    );
  }
}