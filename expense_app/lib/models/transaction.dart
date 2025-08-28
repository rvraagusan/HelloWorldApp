
import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 1)
class TransactionModel extends HiveObject {
  @HiveField(0)
  String envelopeId;

  @HiveField(1)
  double amount;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String type;

  TransactionModel({
    required this.envelopeId,
    required this.amount,
    required this.date,
    required this.type,
  });
}