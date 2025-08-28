

import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/envelope.dart';

class TransactionsScreen extends StatelessWidget {
  final Envelope envelope;
  final int index;

  TransactionsScreen({required this.envelope, required this.index});

  final Box<TransactionModel> transactionBox = Hive.box<TransactionModel>('transactions');
  final Box<Envelope> envelopeBox = Hive.box<Envelope>('envelopes');

  void _addTransaction(BuildContext context) {
    TextEditingController amountCtrl = TextEditingController();

    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: Text("Add Transaction"),
        content: TextField(
          controller: amountCtrl,
          decoration: InputDecoration(labelText: "Amount"),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () {
              final txn = TransactionModel(
                envelopeId: envelope.key.toString(), 
                amount: double.tryParse(amountCtrl.text) ?? 0, 
                date: DateTime.now(), 
                type: "expense",
              );

              transactionBox.add(txn);

              envelope.spent += txn.amount;
              envelope.save();

              Navigator.pop(context);
            }, 
            child: Text("Save"), 
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final envelopeTxns = transactionBox.values.where((txn) => txn.envelopeId == envelope.key.toString());

    return Scaffold(
      appBar: AppBar(title: Text("${envelope.name}")),
      body: ListView(
        children: envelopeTxns.map((txn) {
          return ListTile(
            title: Text("\$${txn.amount}"),
            subtitle: Text(txn.date.toString()),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addTransaction(context),
      ),
    );
  }
}