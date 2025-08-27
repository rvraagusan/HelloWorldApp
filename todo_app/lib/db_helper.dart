import 'package:hive/hive.dart';

class DBHelper {
  final Box _box = Hive.box('tasks');

  Future<int> insertTask(Map<String, dynamic> task) async {
    return await _box.add(task);
  }

  Future<List<Map>> getTasks() async {
    return _box.keys.map((key) {
      final value = _box.get(key);
      return {
        'id': key,
        'task': value['task'],
        'isDone': value['isDone'],
      };
    }).toList();
  }

  Future<void> updateTask(int id, int isDone) async { 
    await _box.put(id, isDone);  
  }

  Future<void> deleteTask(int id) async {
    await _box.delete(id);
  }
}