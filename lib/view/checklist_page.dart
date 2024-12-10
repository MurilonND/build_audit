import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChecklistPage extends StatefulWidget {
  final String apartmentName;
  final String tower;

  ChecklistPage({Key? key, required this.apartmentName, required this.tower}) : super(key: key);

  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  List<Map<String, dynamic>> checklistItems = [];

  @override
  void initState() {
    super.initState();
    _loadChecklist();
  }

  // Carregar checklist específico para o apartamento usando 'checklist_<apartmentName>'
  Future<void> _loadChecklist() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('checklist_${widget.apartmentName}_${widget.tower}');
    if (data != null) {
      setState(() {
        checklistItems = List<Map<String, dynamic>>.from(json.decode(data));
      });
    } else {
      checklistItems = [
      ];
    }
  }

  // Salvar checklist específico para o apartamento
  Future<void> _saveChecklist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('checklist_${widget.apartmentName}_${widget.tower}', json.encode(checklistItems));
  }

  void _addChecklistItem(String title) {
    setState(() {
      checklistItems.add({'title': title, 'isChecked': false});
      _saveChecklist();
    });
  }

  void _openAddChecklistModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final titleController = TextEditingController();
        return AlertDialog(
          title: Text('Adicionar Item à Checklist'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Descrição do item'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  _addChecklistItem(titleController.text);
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
        title: Text('Checklist - ${widget.apartmentName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _openAddChecklistModal,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: checklistItems.length,
        itemBuilder: (context, index) {
          final item = checklistItems[index];
          return CheckboxListTile(
            title: Text(item['title']),
            value: item['isChecked'],
            onChanged: (bool? value) {
              setState(() {
                item['isChecked'] = value!;
                _saveChecklist();
              });
            },
          );
        },
      ),
    );
  }
}
