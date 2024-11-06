import 'package:build_audit/view/tower_list_page.dart';
import 'package:flutter/material.dart';

class ConstructionSitesListPage extends StatelessWidget {
  ConstructionSitesListPage({Key? key}) : super(key: key);

  // Exemplo de lista de construções
  final List<Map<String, String>> constructions = [
    {'title': 'Edifício Alfa', 'description': 'Uma construção residencial moderna.'},
    {'title': 'Centro Comercial Beta', 'description': 'Shopping com várias lojas.'},
    {'title': 'Fábrica Gama', 'description': 'Instalação industrial em expansão.'},
    {'title': 'Hospital Delta', 'description': 'Centro de saúde de última geração.'},
    {'title': 'Escritório Zeta', 'description': 'Prédio corporativo inovador.'},
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