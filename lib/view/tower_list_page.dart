import 'package:build_audit/view/apartment_list_page.dart';
import 'package:flutter/material.dart';

class TowerListPage extends StatelessWidget {
  TowerListPage({Key? key}) : super(key: key);

  // Exemplo de lista de torres
  final List<Map<String, String>> towers = [
    {'title': 'Torre Norte', 'description': 'Torre de vigilância com vista panorâmica.'},
    {'title': 'Torre Sul', 'description': 'Torre residencial com vinte andares.'},
    {'title': 'Torre Leste', 'description': 'Torre comercial com escritórios modernos.'},
    {'title': 'Torre Oeste', 'description': 'Torre histórica com arquitetura clássica.'},
    {'title': 'Torre Central', 'description': 'A mais alta torre de telecomunicações da cidade.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Torres'),
      ),
      body: ListView.builder(
        itemCount: towers.length,
        itemBuilder: (context, index) {
          final tower = towers[index];
          return ListTile(
            leading: Icon(Icons.apartment, color: Colors.blue),
            title: Text(tower['title'] ?? ''),
            // subtitle: Text(tower['description'] ?? ''),
            onTap: () {
              Navigator.push( context, MaterialPageRoute(builder: (context) => ApartmentListPage(towerName: tower['title']!,)), );
            },
          );
        },
      ),
    );
  }
}