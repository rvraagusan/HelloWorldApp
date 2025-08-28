
import 'package:hive/hive.dart';

part 'envelope.g.dart';

@HiveType(typeId: 0)
class Envelope extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double budget;

  @HiveField(2)
  double spent;

  Envelope({required this.name, required this.budget, this.spent =0});
}