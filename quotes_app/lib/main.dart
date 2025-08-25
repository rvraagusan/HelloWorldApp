import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Quotes App",
      home: QuotesListScreen(),
    );
  }
}

class QuotesListScreen extends StatelessWidget {
  const QuotesListScreen({super.key});

  final List<Map<String, String>> quotes = const[
    {"quote": "The best way to product the future is to invent it.", "author": "Alan Kay"},
    {"quote": "Stay hungry, stay foolish.", "author": "Steve Jobs"},
    {"quote": "Code is like humor. When you have to explain it, it’s bad.", "author": "Cory House"},
    {"quote": "Simplicity is the soul of efficiency.", "author": "Austin Freeman"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes List"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          final quote = quotes[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(quote["quote"]!),
              subtitle: Text("- ${quote["author"]!}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => QuoteDetailScreen(
                    quote: quote["quote"]!, 
                    author: quote["author"]!,
                    )
                    )
                );
              },
            ),
          );
        }),
    );
  }
}

class QuoteDetailScreen extends StatelessWidget {
  final String quote;
  final String author;

  const QuoteDetailScreen({super.key, required this.quote, required this.author});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quote Details"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\"$quote\"",
                style: const TextStyle(
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                "- $author",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          ),
      ),
    );
  }
}