import 'package:flutter/material.dart';
import 'package:student_task_manager/models/task.dart';

class HomeScreen extends StatefulWidget {
 const HomeScreen({super.key});

 @override
 State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>{
  final List<Task> _tasks = [];

  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    String text = _controller.text.trim();
    if(text.isNotEmpty){
      setState(() {
        _tasks.add(Task(title: text));
        _controller.clear();
      });
      FocusScope.of(context).unfocus(); //Hiding Keyboard after adding task
    }
  }

  @override
  Widget build(BuildContext context) {
   int completedTaskCount = _tasks.where((t) => t.isDone).length;

   return Scaffold(
    appBar: AppBar(
      title: const Text('Task Manager'),
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Hoàn thành: $completedTaskCount/${_tasks.length}'),
          const SizedBox(height: 10),

          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Nhập công việc',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: _addTask,
              ),
            ),
          ),
          const SizedBox(height: 20),

        Expanded( 
          child: _tasks.isEmpty 
            ? const Center(child: Text("Chưa có công việc nào!"))
            : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
              return _buildTaskItem(_tasks[index], index);
              },
            ),
          ),
        ],
      )
    )
   );
  }
  
  Widget _buildTaskItem (Task task, int index) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Checkbox(value: task.isDone,
         onChanged: (bool? value) {
          setState(() {
            task.isDone = value ?? false;
          });
        }),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
            color: task.isDone ? Colors.grey : Colors.black,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent,),
          onPressed: () {
            setState(() {
              _tasks.removeAt(index);
            });
          },
        ),
      ),
    );
  }
}

