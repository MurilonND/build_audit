import 'package:flutter/material.dart';

class ChecklistPage extends StatefulWidget {
  final String apartmentName;

  ChecklistPage({Key? key, required this.apartmentName}) : super(key: key);

  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  // Lista de itens da checklist
  final List<Map<String, dynamic>> checklistItems = [
    {'title': 'Inspecionar sistema elétrico', 'isChecked': false},
    {'title': 'Verificar sistema de encanamento', 'isChecked': false},
    {'title': 'Checar portas e janelas', 'isChecked': false},
    {'title': 'Testar detectores de fumaça', 'isChecked': false},
    {'title': 'Revisar pintura e acabamentos', 'isChecked': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist - ${widget.apartmentName}'),
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
              });
            },
          );
        },
      ),
    );
  }
}
