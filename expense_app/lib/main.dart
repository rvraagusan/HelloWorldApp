import 'package:expense_app/models/envelope.dart';
import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(EnvelopeAdapter());
  Hive.registerAdapter(TransactionModelAdapter());

  await Hive.openBox<Envelope>('envelopes');
  await Hive.openBox<TransactionModel>('transactions');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Good Budget Clone App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
