import 'package:flutter/material.dart';

void main() => runApp(ContactListApp());

class ContactListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Contact {
  final String name;
  final String number;
  Contact(this.name, this.number);
}

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final List<Contact> _contacts = [];

  void _addContact() {
    final name = _nameController.text.trim();
    final number = _numberController.text.trim();
    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        _contacts.add(Contact(name, number));
        _nameController.clear();
        _numberController.clear();
      });
    }
  }

  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure for Delete?'),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _deleteContact(index);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _numberController,
              decoration: InputDecoration(
                hintText: 'Number',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addContact,
                child: Text('Add'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return GestureDetector(
                    onLongPress: () => _showDeleteDialog(index),
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          contact.name,
                          style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(contact.number),
                        trailing: Icon(Icons.phone, color: Colors.blue),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}