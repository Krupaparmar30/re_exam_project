
import 'package:get/get.dart';
import 'package:re_exam_project/screen/firebase.dart';
import 'package:re_exam_project/screen/modal/modal.dart';

import '../helper/helper.dart';

class Controller extends GetxController {
  final DBService _dbService = DBService();
  var tasks = <Modal>[].obs;
  FirestoreService _firestoreService = FirestoreService();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    tasks.value = await _dbService.getTasks();
  }

  void addTask(Modal task) async {
    await _dbService.insertTask(task);
    fetchTasks();
  }

  void updateTask(Modal task) async {
    await _dbService.updateTask(task);
    fetchTasks();
  }

  void deleteTask(int id) async {
    await _dbService.deleteTask(id);
    fetchTasks();
  }

  void toggleTaskCompletion(Modal task) async {
    task.status = task.status == 'Pending' ? 'Completed' : 'Pending';
    // await updateTask(task);
  }

  Future<void> fetchTasksFromFirebase() async {
    List<Modal> firestoreTasks =
    await _firestoreService.fetchTasksFromFirestore();
    for (Modal task in firestoreTasks) {
      await _dbService.insertTask(task); // Insert Firestore tasks into SQLite
    }
    fetchTasks();
  }

  void sortByPriority() {
    tasks.sort((a, b) {
      Map<String, int> priorityMap = {'High': 3, 'Medium': 2, 'Low': 1};
      return priorityMap[b.priority]!.compareTo(priorityMap[a.priority]!);
    });
  }

  Future<void> syncTasksWithFirebase() async {
    for (Modal task in tasks) {
      await _firestoreService.uploadTaskToFirestore(task);
    }
    Get.snackbar('Sync', 'All tasks synced with Firebase');

    Get.snackbar('Sync', 'All tasks synced with Firebase');
  }

  void sortByDueDate() {
    tasks.sort((a, b) {
      return DateTime.parse(a.dueDate).compareTo(DateTime.parse(b.dueDate));
    });
  }
}
