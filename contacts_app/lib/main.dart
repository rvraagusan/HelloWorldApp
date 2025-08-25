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
      title: "Contacts App",
      home: ContactsScreen(),
    );
  }
}

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final List<Map<String, String>> contacts = [
    {"name": "Alice Johnson", "phone": "+94 71 111 1111"},
    {"name": "Bob Smith", "phone": "+94 72 222 2222"},
    {"name": "Charlie Brown", "phone": "+94 73 333 3333"},
    {"name": "David Williams", "phone": "+94 74 444 4444"},
    {"name": "Emma Watson", "phone": "+94 75 555 5555"},
  ];

  String searchQuery = "";

  @override 
  Widget build(BuildContext context) {
    final filteredContacts = contacts.where((contact){
      final name = contact["name"]!.toLowerCase();
      return name.contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Contacts...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredContacts.length,
                itemBuilder: (context, index){
                  final contact = filteredContacts[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal,
                        child: Text(contact["name"]![0]),
                      ),
                      title: Text(contact["name"]!),
                      subtitle: Text(contact["phone"]!),
                      trailing: IconButton(
                        icon: const Icon(Icons.phone, color: Colors.green,),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Calling ${contact["name"]}...")),
                          );
                        },
                      ), 
                    ),
                  );
                }
              ),
            ),
        ],
      ),
    );
  }
}