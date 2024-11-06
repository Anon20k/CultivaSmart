import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'screens/map_screen.dart';
import 'logica/saved_calculations_screen.dart';
import 'screens/Terrain.dart';
import 'screens/encyclopedia_screen.dart'; // Importa el nuevo archivo de la enciclopedia

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  List<Map<String, dynamic>> _calculations = [];

  void _addCalculation(Map<String, dynamic> calculation) {
    setState(() {
      _calculations.add(calculation);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      EncyclopediaScreen(), // Añade la enciclopedia de variedades de plantas
      const MapScreen(),
      const AddScreen(),
      Terrain(onCalculationSaved: _addCalculation), // Pasa la función de callback
      SavedCalculationsScreen(calculations: _calculations), // Pasa la lista de cálculos
    ];

    return Scaffold(
      appBar: _page == 0 // Solo mostrar el AppBar en la página principal
          ? AppBar(
              title: const Text('Enciclopedia'), // Título de la página principal
              backgroundColor: Colors.green,
            )
          : null,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.green,
        color: Colors.green,
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.book, size: 26, color: Colors.white), // Ícono para la enciclopedia
          Icon(Icons.map, size: 26, color: Colors.white),
          Icon(Icons.add, size: 50, color: Colors.white),
          Icon(Icons.calculate, size: 26, color: Colors.white),
          Icon(Icons.list, size: 26, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: IndexedStack(
        index: _page,
        children: _pages,
      ),
    );
  }
}

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Add',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}