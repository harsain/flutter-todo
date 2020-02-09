import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/model/task.dart';

void main() => runApp(TodoApp());


class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo App",
      home: TodoList()
    );
  }

}


class TodoList extends StatefulWidget {
  @override
  createState() => TodoListState();
}

class TodoListState extends State<TodoList> {

  List<Task> _todoItems = [];

  void _addTodoItem(String taskText) {
    setState(() {
      Task task = new Task();
      task.id = _todoItems.length + 1;
      task.text = taskText;

      _todoItems.add(task);
    });
  }

  void _removeTask(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _toggleFavourite(int index) {

    setState(() {
      _todoItems[index].favourite = !_todoItems[index].favourite;
    });
  }

  Widget _buildTodoItem(Task task, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),

      actionExtentRatio: 0.25,

      child: Container(

        color: Colors.white,
        child: ListTile(

          title: Text(task.text),

        ),

      ),

      secondaryActions: <Widget>[

        IconSlideAction(

          caption: "Follow",
          color: Colors.grey,
          icon: _todoItems[index].favourite ? Icons.favorite : Icons.favorite_border,
          onTap: (){_toggleFavourite(index);},

        ),

        IconSlideAction(

          caption: "Delete",
          color: Colors.red,
          icon: Icons.delete,
          onTap: (){_removeTask(index);},

        ),

      ],

    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      // ignore: missing_return
      itemBuilder: (context, index) {

        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
//        return ExpansionTile(
//            key: PageStorageKey<int>(index),
//            title: Text("Pending tasks"),
//            children: _buildTasks(index),
//        );


    });
  }

  _buildTasks(int index) {
    List<Widget> taskList = [];
    if (index < _todoItems.length) {
      taskList.add(_buildTodoItem(_todoItems[index], index));
    }
    return taskList;
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: AppBar(
            title: Text("Add a new task"),
          ),
          body: TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context); // close the add task screen
            },
            decoration: InputDecoration(
              hintText: "Enter something to do...",
              contentPadding: const EdgeInsets.all(16.0)
            ),
          ),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Todo List"),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: "Add Task",
        child: Icon(Icons.add),
      ),
    );
  }

}