import 'package:flutter/material.dart';

class SavedCalculationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> calculations;

  const SavedCalculationsScreen({Key? key, required this.calculations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas guardadas'),
      ),
      body: ListView.builder(
        itemCount: calculations.length,
        itemBuilder: (context, index) {
          final calculation = calculations[index];
          return ListTile(
            leading: Image.asset(calculation['image'], height: 50, width: 50),
            title: Text(calculation['name']),
            subtitle: Text('Variety: ${calculation['variety']}, Soil: ${calculation['soilType']}, Hectares: ${calculation['hectares']}, Total Plants: ${calculation['totalPlants']}'),
          );
        },
      ),
    );
  }
}