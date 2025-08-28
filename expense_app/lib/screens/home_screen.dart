

import 'package:expense_app/models/envelope.dart';
import 'package:expense_app/screens/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatelessWidget {
  final Box<Envelope> envelopeBox = Hive.box<Envelope>('envelopes');

  void _addEnvelope(BuildContext context) {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController budgetCtrl = TextEditingController();

    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: Text('Add Envelope'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: budgetCtrl, decoration: InputDecoration(labelText: "Budget"), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final envelope = Envelope(
                name: nameCtrl.text, 
                budget: double.tryParse(budgetCtrl.text) ?? 0,
              );
              envelopeBox.add(envelope);
              Navigator.pop(context);
            }, 
            child: Text('save'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GoodBudget")),
      body: ValueListenableBuilder(
        valueListenable: envelopeBox.listenable(), 
        builder: (context, Box<Envelope> box, _) {
          if (box.isEmpty) {
            return Center(child: Text("No Envelopes yet. Add one!"));
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final envelope = box.getAt(index)!;
              final progress = (envelope.spent / envelope.budget).clamp(0.0, 1.0);

              return ListTile(
                title: Text(envelope.name),
                subtitle: LinearProgressIndicator(value: progress),
                trailing: Text("\$${envelope.spent} / \$${envelope.budget}"),
                onTap: () => Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (_) => TransactionsScreen(envelope: envelope, index: index),
                  ),
                ),
              );
            }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addEnvelope(context)
      ),
    );
  }
}