import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'apartment_list_page.dart';

class TowerListPage extends StatefulWidget {
  TowerListPage({Key? key}) : super(key: key);

  @override
  _TowerListPageState createState() => _TowerListPageState();
}

class _TowerListPageState extends State<TowerListPage> {
  List<Map<String, String>> towers = [];

  @override
  void initState() {
    super.initState();
    _loadTowers();
  }

  Future<void> _loadTowers() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('towers');
    if (data != null) {
      final List<dynamic> decodedData = json.decode(data); // Decode the data
      setState(() {
        towers = decodedData.map<Map<String, String>>((item) {
          return {
            'title': item['title'] ?? '', // Ensure that each key is a String
            'description':
                item['description'] ?? '', // Ensure that each key is a String
          };
        }).toList();
      });
    } else {
      setState(() {
        towers = [];
      });
    }
  }

  Future<void> _saveTowers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('towers', json.encode(towers));
      print('Towers saved: ${json.encode(towers)}');
    } catch (e) {
      print(e);
    }
  }

  void _addTower(String title, String description) {
    setState(() {
      towers.add({'title': title, 'description': description});
      _saveTowers();
    });
  }

  void _openAddTowerModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final titleController = TextEditingController();
        final descriptionController = TextEditingController();
        return AlertDialog(
          title: Text('Adicionar Torre'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Nome da Torre'),
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
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  _addTower(titleController.text, descriptionController.text);
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
        title: Text('Lista de Torres'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _openAddTowerModal,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: towers.length,
        itemBuilder: (context, index) {
          final tower = towers[index];
          return ListTile(
            leading: Icon(Icons.apartment, color: Colors.blue),
            title: Text(tower['title'] ?? ''),
            subtitle: Text(tower['description'] ?? ''),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ApartmentListPage(towerName: tower['title']!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
