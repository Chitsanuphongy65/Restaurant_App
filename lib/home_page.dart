import 'package:flutter/material.dart';
import 'add_page.dart';
import 'menu_item.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MenuItem> _menuItems = [];

  void _addMenuItem(MenuItem item) {
    setState(() {
      _menuItems.add(item);
    });
  }

  void _deleteMenuItem(int index) {
    setState(() {
      _menuItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant App', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green, // Changed to green
      ),
      body: ListView.builder(
        itemCount: _menuItems.length,
        itemBuilder: (context, index) {
          final item = _menuItems[index];
          return Dismissible(
            key: Key(item.name),
            onDismissed: (direction) {
              _deleteMenuItem(index);
            },
            background: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white, size: 30),
            ),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Colors.green.withOpacity(0.3), // Changed to green
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                leading: CircleAvatar(
                  backgroundColor: Colors.green, // Changed to green
                  child: Icon(Icons.fastfood, color: Colors.white),
                ),
                title: Text(
                  item.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  'ราคา: ${item.price} บาท\nประเภท: ${item.category}\nวันที่: ${DateFormat('dd/MM/yyyy').format(item.date)}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newItem = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          );
          if (newItem != null) {
            _addMenuItem(newItem);
          }
        },
        label: Text('เพิ่มเมนูอาหาร', style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255))),
        icon: Icon(Icons.add, color: Colors.white), // Changed to white
        backgroundColor: Colors.green, // Changed to green
      ),
    );
  }
}
