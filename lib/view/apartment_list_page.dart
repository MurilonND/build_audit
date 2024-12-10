import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'checklist_page.dart';
import 'file_viewer_page.dart';

class ApartmentListPage extends StatefulWidget {
  final String towerName;

  ApartmentListPage({Key? key, required this.towerName}) : super(key: key);

  @override
  _ApartmentListPageState createState() => _ApartmentListPageState();
}

class _ApartmentListPageState extends State<ApartmentListPage> {
  List<Map<String, String>> apartments = [];

  @override
  void initState() {
    super.initState();
    _loadApartments();
  }

  Future<void> _loadApartments() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('tower_${widget.towerName}'); // Use the tower name as key
    if (data != null) {
      final List<dynamic> decodedData = json.decode(data); // Decode the data into a list
      setState(() {
        apartments = decodedData.map<Map<String, String>>((item) {
          return {
            'title': item['title'] ?? '', // Ensure each key is a string
            'description': item['description'] ?? '', // Ensure each key is a string
          };
        }).toList();
      });
    }
  }

  Future<void> _saveApartments() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tower_${widget.towerName}', json.encode(apartments)); // Save data under the tower name
  }

  void _addApartment(String title, String description) {
    setState(() {
      apartments.add({'title': title, 'description': description});
      _saveApartments();
    });
  }

  void _openAddApartmentModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final titleController = TextEditingController();
        final descriptionController = TextEditingController();
        return AlertDialog(
          title: Text('Adicionar Apartamento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                  _addApartment(titleController.text, descriptionController.text);
                  Navigator.pop(context);
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apartamentos em ${widget.towerName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _openAddApartmentModal,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: apartments.length,
        itemBuilder: (context, index) {
          final apartment = apartments[index];
          return ListTile(
            leading: Icon(Icons.home, color: Colors.blue),
            title: Text(apartment['title'] ?? ''),
            subtitle: Text(apartment['description'] ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChecklistPage(apartmentName: apartment['title'] ?? '', tower: widget.towerName,),
                      ),
                    );
                  },
                  icon: Icon(Icons.check),
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DocumentPage(apartmentName: apartment['title'] ?? ''),
                      ),
                    );
                  },
                  icon: Icon(Icons.file_open),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
