import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../contoller/controller.dart';
import '../modal/modal.dart';

class homePage extends StatelessWidget {
  final Controller taskController = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Center(
            child: Text(
          'Todo App',
          style: TextStyle(color: Colors.white),
        )),
        actions: [
          IconButton(
            icon: Icon(
              Icons.sync,
              color: Colors.white,
            ),
            onPressed: () {
              taskController.syncTasksWithFirebase();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.backpack,
              color: Colors.white,
            ),
            onPressed: () async {
              taskController.fetchTasksFromFirebase();
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Priority') {
                taskController.sortByPriority();
              } else if (value == 'Due Date') {
                taskController.sortByDueDate();
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Priority', 'Due Date'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (taskController.tasks.isEmpty) {
          return Center(child: Text('No tasks available'));
        }
        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            Modal task = taskController.tasks[index];

            // Format the due date
            // String dueDate =
            // DateFormat.yMMMd().format(DateTime.parse(task.dueDate));

            // Define the task priority color
            Color priorityColor;
            switch (task.priority) {
              case 'High':
                priorityColor = Colors.red;
                break;
              case 'Medium':
                priorityColor = Colors.orange;
                break;
              default:
                priorityColor = Colors.green;
            }


            IconData statusIcon = task.status == 'Completed'
                ? Icons.check_circle
                : Icons.circle_outlined;

            return ListTile(
              leading: Icon(statusIcon,
                  color:
                      task.status == 'Completed' ? Colors.green : Colors.grey),
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.status == 'Completed'
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              // subtitle: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(task.description),
              //     SizedBox(height: 5),
              //     Text('Due: $dueDate'),
              //   ],
              // ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(task.priority, style: TextStyle(color: priorityColor)),
                  InkWell(
                      onTap: () {
                        taskController.deleteTask(task.id!);
                      },
                      child: Icon(Icons.delete, color: Colors.red)),
                ],
              ),
              onTap: () {
                taskController.toggleTaskCompletion(task);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    DateTime? selectedDate;
    String selectedPriority = 'Low';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                SizedBox(height: 10),
                DropdownButton<String>(
                  value: selectedPriority,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      selectedPriority = newValue;
                    }
                  },
                  items: <String>['Low', 'Medium', 'High']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      selectedDate = pickedDate;
                    }
                  },
                  child: Text('Select Due Date'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && selectedDate != null) {
                  Modal newTask = Modal(
                    title: titleController.text,
                    description: descriptionController.text,
                    dueDate: selectedDate!.toIso8601String(),
                    priority: selectedPriority,
                    status: 'Pending',
                  );
                  taskController.addTask(newTask);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
