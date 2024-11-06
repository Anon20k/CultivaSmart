import 'package:flutter/material.dart';
import 'package:flutter_app/logica/logic_plantac.dart'; // ARCHIVO DE CALCULO

class Terrain extends StatefulWidget {
  final Function(Map<String, dynamic>) onCalculationSaved;

  const Terrain({Key? key, required this.onCalculationSaved}) : super(key: key);

  @override
  _TerrainState createState() => _TerrainState();
}

class _TerrainState extends State<Terrain> {
  final TextEditingController _hectaresController = TextEditingController();
  final TextEditingController _calculationNameController = TextEditingController();

  String _selectedVariety = 'Cabernet Sauvignon';
  String _selectedSoilType = 'Fértil';
  double _distanceBetweenPlants = 1.75; // Promedio inicial para Cabernet Sauvignon en tierra fértil
  double _distanceBetweenRows = 3.0; // Supuesto constante para el tamaño del tractor

  double _minDistance = 1.5;
  double _maxDistance = 2.0;
  String _selectedImage = 'assets/uva3.png';

  final Map<String, String> _varietyImages = {
    'Cabernet Sauvignon': 'assets/uva4.png',
    'Sauvignon Blanc': 'assets/uva3.png',
    'Merlot': 'assets/uva2.png',
    'Carmenère': 'assets/uva4.png',
    'Chardonnay': 'assets/uva3.png',
    'Syrah': 'assets/uva4.png',
    'Pinot Noir': 'assets/uva4.png',
    'Pais': 'assets/uva4.png',
    'Malbec': 'assets/uva4.png',
    'Carignan': 'assets/uva4.png',
    'Riesling': 'assets/uva3.png',
    'Gewürztraminer': 'assets/uva3.png',
    'Semillon': 'assets/uva3.png',
    'Viognier': 'assets/uva3.png',
    'Petit Verdot': 'assets/uva4.png',
    'Tempranillo': 'assets/uva4.png',
    'Cabernet Franc': 'assets/uva4.png',
    'Grenache': 'assets/uva4.png',
    'Marsanne': 'assets/uva3.png',
    'Mourvèdre': 'assets/uva4.png',
  };

  final Map<String, Map<String, double>> _varietiesFertile = {
    'Cabernet Sauvignon': {'min': 1.5, 'max': 2.0},
    'Sauvignon Blanc': {'min': 1.5, 'max': 2.0},
    'Merlot': {'min': 1.5, 'max': 2.0},
    'Carmenère': {'min': 1.5, 'max': 2.0},
    'Chardonnay': {'min': 1.5, 'max': 2.0},
    'Syrah': {'min': 1.5, 'max': 2.5},
    'Pinot Noir': {'min': 1.5, 'max': 2.0},
    'Pais': {'min': 1.5, 'max': 2.0},
    'Malbec': {'min': 1.5, 'max': 2.0},
    'Carignan': {'min': 1.5, 'max': 2.0},
    'Riesling': {'min': 1.5, 'max': 2.0},
    'Gewürztraminer': {'min': 1.5, 'max': 2.0},
    'Semillon': {'min': 1.5, 'max': 2.0},
    'Viognier': {'min': 1.5, 'max': 2.0},
    'Petit Verdot': {'min': 1.5, 'max': 2.0},
    'Tempranillo': {'min': 1.5, 'max': 2.0},
    'Cabernet Franc': {'min': 1.5, 'max': 2.0},
    'Grenache': {'min': 1.5, 'max': 2.0},
    'Marsanne': {'min': 1.5, 'max': 2.0},
    'Mourvèdre': {'min': 1.5, 'max': 2.0},
  };

  final Map<String, Map<String, double>> _varietiesInfertile = {
    'Cabernet Sauvignon': {'min': 1.0, 'max': 1.5},
    'Sauvignon Blanc': {'min': 1.0, 'max': 1.5},
    'Merlot': {'min': 1.0, 'max': 1.5},
    'Carmenère': {'min': 1.0, 'max': 1.5},
    'Chardonnay': {'min': 1.0, 'max': 1.5},
    'Syrah': {'min': 1.0, 'max': 2.0},
    'Pinot Noir': {'min': 1.0, 'max': 1.5},
    'Pais': {'min': 1.0, 'max': 1.5},
    'Malbec': {'min': 1.0, 'max': 1.5},
    'Carignan': {'min': 1.0, 'max': 1.5},
    'Riesling': {'min': 1.0, 'max': 1.5},
    'Gewürztraminer': {'min': 1.0, 'max': 1.5},
    'Semillon': {'min': 1.0, 'max': 1.5},
    'Viognier': {'min': 1.0, 'max': 1.5},
    'Petit Verdot': {'min': 1.0, 'max': 1.5},
    'Tempranillo': {'min': 1.0, 'max': 1.5},
    'Cabernet Franc': {'min': 1.0, 'max': 1.5},
    'Grenache': {'min': 1.0, 'max': 1.5},
    'Marsanne': {'min': 1.0, 'max': 1.5},
    'Mourvèdre': {'min': 1.0, 'max': 1.5},
  };

  double _totalPlants = 0;

  void _calculatePlants() {
    final double hectares = double.tryParse(_hectaresController.text) ?? 0;
    final String calculationName = _calculationNameController.text;

    if (hectares > 0 && _distanceBetweenPlants > 0 && _distanceBetweenRows > 0 && calculationName.isNotEmpty) {
      setState(() {
        _totalPlants = calculateTotalPlants(hectares, _distanceBetweenPlants, _distanceBetweenRows);
        widget.onCalculationSaved({
          'name': calculationName,
          'hectares': hectares,
          'variety': _selectedVariety,
          'soilType': _selectedSoilType,
          'distanceBetweenPlants': _distanceBetweenPlants,
          'distanceBetweenRows': _distanceBetweenRows,
          'totalPlants': _totalPlants,
          'image': _selectedImage,
        });
        _hectaresController.clear();
        _calculationNameController.clear();
      });
    } else {
      setState(() {
        _totalPlants = 0;
      });
    }
  }

  void _updateDistances() {
    setState(() {
      Map<String, double> distances = _selectedSoilType == 'Fértil'
          ? _varietiesFertile[_selectedVariety]!
          : _varietiesInfertile[_selectedVariety]!;
      _minDistance = distances['min']!;
      _maxDistance = distances['max']!;
      _distanceBetweenPlants = (_minDistance + _maxDistance) / 2;
      _selectedImage = _varietyImages[_selectedVariety]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _calculationNameController,
              decoration: InputDecoration(
                labelText: 'Nombre de plantacion',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _hectaresController,
              decoration: InputDecoration(
                labelText: 'Hectareas',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedVariety,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _selectedVariety = newValue;
                  _updateDistances();
                }
              },
              items: _varietiesFertile.keys.map((String variety) {
                return DropdownMenuItem<String>(
                  value: variety,
                  child: Text(variety),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedSoilType,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _selectedSoilType = newValue;
                  _updateDistances();
                }
              },
              items: ['Fértil', 'Infértil'].map((String soilType) {
                return DropdownMenuItem<String>(
                  value: soilType,
                  child: Text(soilType),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text('Distancia entre plantas: $_distanceBetweenPlants m'),
            Slider(
              value: _distanceBetweenPlants,
              min: _minDistance,
              max: _maxDistance,
              divisions: 10,
              label: _distanceBetweenPlants.toStringAsFixed(2),
              onChanged: (double value) {
                setState(() {
                  _distanceBetweenPlants = value;
                });
              },
            ),
            Text('Distacia entre Hileras: $_distanceBetweenRows m'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculatePlants,
              child: Text('Calcular'),
            ),
            SizedBox(height: 16),
            Text(
              'Total Plantas: $_totalPlants',
              style: TextStyle(fontSize: 24),
            ),
            if (_totalPlants > 0) Image.asset(_selectedImage, height: 100),
          ],
        ),
      ),
    );
  }
}