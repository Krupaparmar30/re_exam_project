
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:re_exam_project/screen/modal/modal.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Upload a task to Firestore
  Future<void> uploadTaskToFirestore(Modal task) async {
    await firestore.collection('tasks').add({
      'title': task.title,
      'description': task.description,
      'dueDate': task.dueDate,
      'priority': task.priority,
      'status': task.status,
    });
  }

  // Fetch all tasks from Firestore
  Future<List<Modal>> fetchTasksFromFirestore() async {
    List<Modal> tasks = [];
    QuerySnapshot snapshot = await firestore.collection('tasks').get();

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Modal task = Modal(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        dueDate: data['dueDate'],
        priority: data['priority'],
        status: data['status'],
      );
      tasks.add(task);
    }
    return tasks;
  }

  // Delete a task from Firestore by document ID
  Future<void> deleteTaskFromFirestore(String taskId) async {
    await firestore.collection('tasks').doc(taskId).delete();
  }

  // Update a task in Firestore by document ID
  Future<void> updateTaskInFirestore(Modal task) async {
    await firestore.collection('tasks').doc(task.id as String?).update({
      'title': task.title,
      'description': task.description,
      'dueDate': task.dueDate,
      'priority': task.priority,
      'status': task.status,
    });
  }
}
