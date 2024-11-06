import 'package:build_audit/view/checklist_page.dart';
import 'package:build_audit/view/file_viewer_page.dart';
import 'package:flutter/material.dart';

class ApartmentListPage extends StatelessWidget {
  final String towerName;

  ApartmentListPage({Key? key, required this.towerName}) : super(key: key);

  // Exemplo de lista de apartamentos
  final List<Map<String, String>> apartments = [
    {'title': 'Apartamento 101', 'description': 'Apartamento de 2 quartos com vista para o parque.'},
    {'title': 'Apartamento 102', 'description': 'Apartamento de 1 quarto, mobiliado.'},
    {'title': 'Apartamento 201', 'description': 'Apartamento de 3 quartos com varanda.'},
    {'title': 'Apartamento 202', 'description': 'Estúdio compacto e funcional.'},
    {'title': 'Apartamento 301', 'description': 'Apartamento de luxo com 4 quartos e suíte.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apartamentos em $towerName'),
      ),
      body: ListView.builder(
        itemCount: apartments.length,
        itemBuilder: (context, index) {
          final apartment = apartments[index];
          return ListTile(
            leading: Icon(Icons.home, color: Colors.blue),
            title: Text(apartment['title'] ?? ''),
            // subtitle: Text(apartment['description'] ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChecklistPage(apartmentName: apartment['title'] ?? ''),
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