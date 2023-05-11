import 'package:flutter/material.dart';
import 'package:listview_one/model/todo.dart';
import '../constants/color.dart';
import '../widget/todo_item.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundTodo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          ' All ToooDoo',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todoo in _foundTodo)
                        TodoItem(
                          todo: todoo,
                          onToDoChange: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: const BoxDecoration(
                      color: Colors.white70,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        hintText: "Add New ToDo item ",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        minimumSize: Size(60, 60),
                        elevation: 10),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    if(toDo.isNotEmpty){
      setState(() {
        todosList.add(ToDo(
            id: DateTime
                .now()
                .millisecondsSinceEpoch
                .toString(),
            todoText: toDo));
      });
    }

    _todoController.clear();
  }


  void _runFiltter(String enterKeyWor) {
    List<ToDo> results = [];
    if (enterKeyWor.isEmpty) {
      results = todosList;
    } else {
      results = todosList.where((item) =>
          item.todoText!.toLowerCase().contains(enterKeyWor.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTodo =results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child:  TextField(
        onChanged: (value)=> _runFiltter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black26,
            size: 20,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGray),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: tdBlack,
              size: 30,
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/boy.jpg'),
              ),
            )
          ],
        ));
  }
}
