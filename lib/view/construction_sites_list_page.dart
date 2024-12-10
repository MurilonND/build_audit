import 'package:build_audit/view/tower_list_page.dart';
import 'package:flutter/material.dart';

class ConstructionSitesListPage extends StatelessWidget {
  ConstructionSitesListPage({Key? key}) : super(key: key);

  // Exemplo de lista de construções
  final List<Map<String, String>> constructions = [
    {'title': 'Edifício Alfa', 'description': 'Uma construção residencial moderna.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Construções'),
      ),
      body: ListView.builder(
        itemCount: constructions.length,
        itemBuilder: (context, index) {
          final construction = constructions[index];
          return ListTile(
            leading: Icon(Icons.location_city, color: Colors.blue),
            title: Text(construction['title'] ?? ''),
            subtitle: Text(construction['description'] ?? ''),
            onTap: () {
              Navigator.push( context, MaterialPageRoute(builder: (context) => TowerListPage()), );
            },
          );
        },
      ),
    );
  }
}