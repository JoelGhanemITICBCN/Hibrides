import 'package:flutter/material.dart';

import 'to_do_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Center(child: Text('To Do')),
        elevation: 0,
      ),
      body: ListView(
        children: [
          ToDoList(),
          ToDoList(),
          ToDoList(),
          ToDoList(),
        ],
      ),
    );
  }
}
