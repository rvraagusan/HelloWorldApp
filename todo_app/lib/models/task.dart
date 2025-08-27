
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String task;

  @HiveField(1)
  bool isDone;

  Task({required this.task, this.isDone = false});
}