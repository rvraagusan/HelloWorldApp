import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/db_helper.dart';
import 'package:todo_app/models/task.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _controller = TextEditingController();
  late Box<Task> taskBox;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box<Task>('tasks');
  }

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      final task = Task(task: _controller.text); 
      taskBox.add(task);
      _controller.clear();
      setState(() {});
    }
  }

  void _toggleTask(Task task) {
    task.isDone = !task.isDone;
    task.save();
    setState(() {});
  }

  void _deleteTask(int index) {
    taskBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do App"),
      ),
      body: ValueListenableBuilder(
        valueListenable: taskBox.listenable(), 
        builder: (context, Box<Task> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No tasks yet"));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final task = box.getAt(index)!;
              return ListTile(
                title: Text(
                  task.task,
                  style: TextStyle(
                    decoration: 
                      task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                leading: Checkbox(
                  value: task.isDone, 
                  onChanged: (_) => _toggleTask(task),
                ),
                trailing: IconButton(
                  onPressed: () => _deleteTask(index), 
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: "Enter a task",
                ),
              ),
            ),
            IconButton(
              onPressed: _addTask, 
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}